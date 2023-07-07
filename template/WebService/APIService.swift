//
//  APIService.swift
//  template
//
//  Created by joonHyoung on 2022/11/15.
//

import Foundation
import UIKit

class APIService: NSObject {
    
    private let sourcesURL = URL(string: Bundle.apiServerUrl)!
    
    func apiToGetEmployeeData(completion: @escaping (Employees) -> Void) {
     
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200..<300
            guard successRange.contains(statusCode) else {
                // handle response error
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                if let empData = try? jsonDecoder.decode(Employees.self, from: data) {
                    completion(empData)
                }
            }
        }.resume()
    }
    
}
