//
//  SplashViewController.swift
//  template
//
//  Created by joonHyoung on 2022/11/16.
//

import UIKit

class SplashViewController: BaseViewController {
    
    class func instance() -> UIViewController {
        if let viewController = UIStoryboard.init(.main).instantiateVC(SplashViewController.self) {
            return viewController
        } else {
            fatalError("Unable to get storyboard")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // working code:
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            // 1초 후 실행될 부분
            // self.switchToMainViewUI()
            self.switchToWebViewUI()
        }
    }
}
