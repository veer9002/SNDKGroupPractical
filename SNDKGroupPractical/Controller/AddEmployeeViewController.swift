//
//  AddEmployeeViewController.swift
//  SNDKGroupPractical
//
//  Created by Manish Sharma on 21/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    private let manager: EmployeeManager = EmployeeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtDOB.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
    }
    
    // MARK: - Toolbar
    @objc func tapDone() {
        if let datePicker = self.txtDOB.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.txtDOB.text = dateformatter.string(from: datePicker.date)
        }
        self.txtDOB.resignFirstResponder()
    }
  
    // MARK:- Button Actions
    @IBAction func addEmployeeAction(_ sender: UIButton) {
        if txtName.text != "" || txtSurname.text != "" || txtDOB.text != "" {
            let employee = Employee(name: txtName.text, surname: txtSurname.text, DOB: txtDOB.text, profilePicture: imgProfilePic.image?.pngData(), id: UUID())
            manager.createEmployee(employee: employee)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.presentAlert(withTitle: "Blank fields", message: "Please enter in all fields")
        }
        
    }
    
    @IBAction func selectImg(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // MARK: - Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let img = info[.originalImage] as? UIImage
        self.imgProfilePic.image = img
        dismiss(animated: true, completion: nil)
    }
    
}
