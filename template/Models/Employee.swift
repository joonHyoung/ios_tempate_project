//
//  Employee.swift
//  template
//
//  Created by joonHyoung on 2022/11/15.
//

import Foundation

struct Employees: Decodable {
    let status: String
    let data: [EmployeeData]
}

struct EmployeeData: Decodable {
    let id, employeeAge: Int
    let employeeSalary: Int64
    let employeeName, profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
