//
//  Bundle.swift
//  template
//
//  Created by joonHyoung on 2022/11/15.
//

import Foundation

extension Bundle {
    /// 앱 이름
    class var appName: String {
        if let value = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            return value
        }
        return ""
    }
    
    /// 앱 버전
    class var appVersion: String {
        if let value = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return value
        }
        return ""
    }
    
    /// 앱 빌드 버전
    class var appBuildVersion: String {
        if let value = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return value
        }
        return ""
    }
    
    /// 앱 번들 ID
    class var bundleIdentifier: String {
        if let value = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String {
            return value
        }
        return ""
    }
    
    /// api server info
    class var apiServerUrl: String {
        if let value = Bundle.main.infoDictionary?["apiServerUrl"] as? String {
            return value
        }
        return ""
    }
}
