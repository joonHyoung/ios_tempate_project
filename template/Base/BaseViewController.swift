//
//  BaseViewController.swift
//  template
//
//  Created by joonHyoung on 2022/11/16.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var nvc: UINavigationController = UINavigationController()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - for App Flow
    // 웹뷰 화면으로 전환
    func switchToWebViewUI() {
        nvc = UINavigationController(rootViewController: WebViewController.instance())
        UIApplication.shared.keyWindowInConnectedScenes?.rootViewController = nvc
        UIApplication.shared.keyWindowInConnectedScenes?.makeKeyAndVisible()
    }
    
    // MARK: - for App Flow
    // main 화면으로 전환
    func switchToMainViewUI() {
        nvc = UINavigationController(rootViewController: ViewController.instance())
        UIApplication.shared.keyWindowInConnectedScenes?.rootViewController = nvc
        UIApplication.shared.keyWindowInConnectedScenes?.makeKeyAndVisible()
    }
    
    /// 앱 스토어 연동
    func moveToAppStore(_ marketUrl: String) {
        if let url = URL(string: marketUrl), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success: Bool) in
                    if success {
                        // exitApp()
                    }})
            } else {  // Fallback on earlier versions
                UIApplication.shared.openURL(url)
                // exitApp()
            }
        }
    }
}
