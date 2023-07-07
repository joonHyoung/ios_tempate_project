//
//  UIApplication+Additions.swift
//  template
//
//  Created by joonHyoung on 2022/11/16.
//

import Foundation
import UIKit

extension UIApplication {
    
    /// The app's key window taking into consideration apps that support multiple scenes.
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
}
