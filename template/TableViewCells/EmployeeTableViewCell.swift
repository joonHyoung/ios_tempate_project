//
//  EmployeeTableViewCell.swift
//  template
//
//  Created by joonHyoung on 2022/11/15.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
 
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeIdLabel: UILabel!
        
    var employee: EmployeeData? {
        didSet {
            // employeeIdLabel.text = employee?.id
            if let id = employee?.id {
                self.employeeIdLabel.text = String(id)
            }
            self.employeeNameLabel.text = employee?.employeeName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
