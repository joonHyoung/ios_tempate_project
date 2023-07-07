//
//  ViewController.swift
//  template
//
//  Created by joonHyoung on 2022/11/14.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var employeeTableView: UITableView!
    
    private var employeeViewModel: EmployeesViewModel!
    private var dataSource: EmployeeTableViewDataSource<EmployeeTableViewCell, EmployeeData>!
    
    class func instance() -> UIViewController {
        if let viewController = UIStoryboard.init(.main).instantiateVC(ViewController.self) {
            return viewController
        } else {
            fatalError("Unable to get storyboard")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callToViewModelForUIUpdate()
    }

    func callToViewModelForUIUpdate() {
        
        self.employeeViewModel = EmployeesViewModel()
        self.employeeViewModel.bindEmployeeViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        
        self.dataSource = EmployeeTableViewDataSource(cellIdentifier: "EmployeeTableViewCell", items: self.employeeViewModel.empData.data, configureCell: { (cell, evm) in
            cell.employeeIdLabel.text = String(evm.id)
            cell.employeeNameLabel.text = evm.employeeName
            
        })
        
        DispatchQueue.main.async {
            self.employeeTableView.dataSource = self.dataSource
            self.employeeTableView.reloadData()
        }
    }

}
