//
//  EmployeeTableViewController.swift
//  SNDKGroupPractical
//
//  Created by Manish Sharma on 21/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import UIKit

class EmployeeTableViewController: UIViewController {

    // MARK:- Properties
    @IBOutlet weak var employeeTableView: UITableView!
   
    private let manager = EmployeeManager()
    var employees : [Employee]? = nil
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        employees = manager.fetchEmployee()
        if(employees != nil && employees?.count != 0)
        {
            self.employeeTableView.reloadData()
        }
    }
    
    @IBAction func addBarButtonAction(_ sender: UIBarButtonItem) {
        if let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEmployeeViewController") as? AddEmployeeViewController {
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    
}

// MARK: - TableView datasource
extension EmployeeTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employees!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as? EmployeeCell else {
            fatalError("Cell not found")
        }
        
        let employee = self.employees![indexPath.row]
        cell.lblNameAndSurname.text = "\(employee.name!) \(employee.surname!)"
        cell.imgProfilePic.image = UIImage(data: employee.profilePicture!)
        cell.lblDOB.text = employee.DOB
        return cell
    }
    
    
}

// MARK: - TableView delegate
extension EmployeeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateEmployeeViewController") as? UpdateEmployeeViewController {
            destinationVC.selectedEmployee = self.employees![self.employeeTableView.indexPathForSelectedRow!.row]
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}


