//
//  EmployeeCell.swift
//  SNDKGroupPractical
//
//  Created by Manish Sharma on 21/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import Foundation
import CoreData

protocol EmployeeRepository {

    func create(employee: Employee)
    func getAll() -> [Employee]?
    func get(byIdentifier id: UUID) -> Employee?
    func update(employee: Employee) -> Bool
    func delete(id: UUID) -> Bool
}


struct EmployeeDataRepository : EmployeeRepository
{
    func create(employee: Employee) {

        let cdEmployee = CDEmployee(context: PersistentStorage.shared.context)
        cdEmployee.employeeDOB = employee.DOB
        cdEmployee.employeeName = employee.name
        cdEmployee.employeeSurname = employee.surname
        cdEmployee.employeeId = employee.id
        cdEmployee.employeeProfilePic = employee.profilePicture
        
        PersistentStorage.shared.saveContext()
    }

    func getAll() -> [Employee]? {

        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDEmployee.self)
        var employees : [Employee] = []
        result?.forEach({ (cdEmployee) in
            employees.append(cdEmployee.convertToEmployee())
        })

        return employees
    }

    func get(byIdentifier id: UUID) -> Employee? {

        let result = getCDEmployee(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToEmployee()
    }

    func update(employee: Employee) -> Bool {

        let cdEmployee = getCDEmployee(byIdentifier: employee.id)
        guard cdEmployee != nil else {return false}
        
        cdEmployee?.employeeDOB = employee.DOB
        cdEmployee?.employeeName = employee.name
        cdEmployee?.employeeSurname = employee.surname
        cdEmployee?.employeeProfilePic = employee.profilePicture

        PersistentStorage.shared.saveContext()
        return true
    }

    func delete(id: UUID) -> Bool {

        let cdEmployee = getCDEmployee(byIdentifier: id)
        guard cdEmployee != nil else {return false}

        PersistentStorage.shared.context.delete(cdEmployee!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    private func getCDEmployee(byIdentifier id: UUID) -> CDEmployee?
    {
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
        let predicate = NSPredicate(format: "employeeId==%@", id as CVarArg)

        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {return nil}
            return result
        } catch let error {
            debugPrint(error)
        }

        return nil
    }

    
}
