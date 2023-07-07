//
//  WebViewController.swift
//  template
//
//  Created by joonHyoung on 2022/11/16.
//

import UIKit
import WebKit

class WebViewController: BaseWebViewController {
    @IBOutlet weak var webContainerView: UIView!
        
    class func instance() -> UIViewController {
        if let viewController = UIStoryboard.init(.main).instantiateVC(WebViewController.self) {
            return viewController
        } else {
            fatalError("Unable to get storyboard")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        
        setWebView()
        webView.loadWebPage("https://www.apple.com/")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    func setWebView() {
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        self.view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
