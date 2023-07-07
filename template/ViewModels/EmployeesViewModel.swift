//
//  EmployeesViewModel.swift
//  template
//
//  Created by joonHyoung on 2022/11/15.
//

import Foundation

class EmployeesViewModel: NSObject {
    
    private var apiService: APIService!
    private(set) var empData: Employees! {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    var bindEmployeeViewModelToController: (() -> Void) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetEmpData()
    }
    
    func callFuncToGetEmpData() {
        self.apiService.apiToGetEmployeeData { (empData) in
            self.empData = empData
        }
    }
    
}
