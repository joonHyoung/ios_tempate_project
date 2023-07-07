//
//  BaseWebViewController.swift
//  template
//
//  Created by joonHyoung on 2022/11/16.
//

import UIKit
import WebKit

extension WKWebView {
    func loadWebPage(_ urlPath: String) {
        guard let url = URL(string: urlPath) else {
            return
        }
        let customRequest = URLRequest(url: url)
        load(customRequest)
    }
}

class NativeWebViewScrollViewDelegate: NSObject, UIScrollViewDelegate {

    // MARK: - Shared delegate
    static var shared = NativeWebViewScrollViewDelegate()

    // MARK: - UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return nil
    }

}

class BaseWebViewController: BaseViewController, WKUIDelegate, WKScriptMessageHandler, WKNavigationDelegate {

//    var webView: WKWebView!
    lazy var webView: WKWebView = {
        // Initialize a user content controller
        let userContentController = WKUserContentController()

        // - Initialize a configuration and set controller
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        // - Initialize webview with configuration
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        // - Webview options
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.isScrollEnabled = true           // Make sure our view is interactable
        webView.scrollView.bounces = false                  // Things like this should be handled in web code
        webView.allowsBackForwardNavigationGestures = false // Disable swiping to navigate
        webView.contentMode = .scaleToFill                  // Scale the page to fill the web view
        
        return webView
    }()
    
    var webViewConfig: WKWebViewConfiguration {
        
        let userContentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        // for play Audio
        configuration.allowsInlineMediaPlayback = true
        configuration.preferences.javaScriptEnabled = true
        configuration.mediaTypesRequiringUserActionForPlayback = .all
        configuration.allowsPictureInPictureMediaPlayback = true
        
        return configuration
    }
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func addIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        activityIndicator.startAnimating()

        view.addSubview(activityIndicator)
    }
    
    fileprivate func removeIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    // 2
    // MARK: - Reading contents of files
    private func readFileBy(name: String, type: String) -> String {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            return "Failed to find path"
        }
        
        do {
            return try String(contentsOfFile: path, encoding: .utf8)
        } catch {
            return "Unkown Error"
        }
    }
    
}

// MARK: - WKNavigationDelegate protocol
extension BaseWebViewController {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(String(describing: navigationAction.request.url))
        
        if let url = navigationAction.request.mainDocumentURL?.absoluteString {
            switch url {
            case _ where url.contains("itunes.apple.com/kr/app/apple-store"):
                self.moveToAppStore(url)
                decisionHandler(.cancel)
                return
            default:
                decisionHandler(.allow)
                return
            }
        }
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(String(describing: webView.url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End loading")
        removeIndicator()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
        removeIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        let nserror = error as NSError
        if nserror.code != NSURLErrorCancelled {
            webView.loadHTMLString("404 - Page Not Found", baseURL: URL(string: "http://www.apple.com/"))
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        
        let code = (error as NSError).code
        guard code != NSURLErrorUnsupportedURL, code != NSURLErrorCancelled else {
            return
        }
        
        if code == NSURLErrorTimedOut { // (-1001) TIMED OUT
            print("[WEB] TIMEOUT error")
        } else if code == NSURLErrorCannotFindHost { // (-1003) SERVER CANNOT BE FOUND
            print("[WEB] SERVER not found")
        } else if code == NSURLErrorFileDoesNotExist { // (-1100) URL NOT FOUND ON SERVER
            print("[WEB] URL not found")
        } else if code == NSURLErrorNotConnectedToInternet {
            print("[WEB] not connected to Internet")
        }

        if code == NSURLErrorTimedOut || code == NSURLErrorCannotFindHost || code == NSURLErrorNotConnectedToInternet {
            let resMsg = """
                         네트워크 오류가 있습니다.
                         앱을 종료하고 다시 실행해 주세요!
                         """
            let alert = UIAlertController(title: "네트워크오류", message: resMsg, preferredStyle: UIAlertController.Style.alert)
            present(alert, animated: false, completion: nil)
            
        }
        removeIndicator()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let statusCode
            = (navigationResponse.response as? HTTPURLResponse)?.statusCode else {
          // if there's no http status code to act on, exit and allow navigation
          decisionHandler(.allow)
          return
        }

        if statusCode >= 500 {
          // error has occurred
            print("[WEB] Server Error Code : \(statusCode)")
        } else if statusCode >= 400 {
          // error has occurred
            print("[WEB] Response Error code : \(statusCode)")
        }
        decisionHandler(.allow)
    }
}

// MARK: - WKScriptMessageHandler protocol
extension BaseWebViewController {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("[WEB] message.name : \(message.name)")
        print("[WEB] message.body : \(message.body)")
    }
}
