//
//  UIStoryboard.swift
//  template
//
//  Created by joonHyoung on 2022/11/16.
//

import UIKit
import Foundation

extension UIStoryboard {
    enum AppStoryBoards: String {
        case
        login,
        main,
        etc
    }
    convenience init(_ storyboard: AppStoryBoards, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue.prefix(1).capitalized + storyboard.rawValue.dropFirst(), bundle: bundle)
    }
}

extension UIStoryboard {
    func instantiateInitialVC<T: UIViewController>() -> T {
        return self.instantiateInitialViewController() as! T
        
    }
    func instantiateVC<T: UIViewController>(_: T.Type) -> T? {
        if #available(iOS 13.0, *) {
            return self.instantiateViewController(identifier: String(describing: T.self)) as? T
        } else {
            return self.instantiateViewController(withIdentifier: String(describing: T.self)) as? T
        }
    }
}
