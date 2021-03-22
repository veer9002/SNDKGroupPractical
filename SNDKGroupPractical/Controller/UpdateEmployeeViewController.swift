//
//  UpdateEmployeeViewController.swift
//  SNDKGroupPractical
//
//  Created by Manish Sharma on 21/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import UIKit

class UpdateEmployeeViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    
    private let manager = EmployeeManager()
    var selectedEmployee: Employee? = nil
    
    // MARK: - VC Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtName.text = selectedEmployee?.name
        self.txtSurname.text = selectedEmployee?.surname
        self.imgProfilePic.image = UIImage(data: (selectedEmployee?.profilePicture)!)
        self.txtDOB.text = selectedEmployee?.DOB

        self.txtDOB.setInputViewDatePicker(target: self, selector: #selector(tapDone))
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
    
    // MARK:- Button Action
    
    @IBAction func updateAction(_ sender: UIButton) {
      
        if txtName.text != "" || txtSurname.text != "" || txtDOB.text != nil {
            let employee = Employee(name: txtName.text, surname: txtSurname.text, DOB: txtDOB.text, profilePicture: imgProfilePic.image?.pngData(), id: selectedEmployee!.id)

            if(manager.updateEmployee(employee: employee))
            {
                displayAlert(alertMessage: "Record Updated")
            }else
            {
                displayErrorAlert()
            }
        } else {
            self.presentAlert(withTitle: "Empty field", message: "One or more field empty")
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        if(manager.deleteEmployee(id: selectedEmployee!.id))
        {
            displayAlert(alertMessage: "Record deleted")
        }
        else
        {
            displayErrorAlert()
        }
    }
    
    // MARK:-  Select image tap gesture action
    @IBAction func selectImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    // MARK: Private functions
    private func displayAlert(alertMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    private func displayErrorAlert()
    {
        let errorAlert = UIAlertController(title: "Alert", message: "Something went wrong, please try again later", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true)
    }
    
}

extension UpdateEmployeeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[.originalImage] as? UIImage
        self.imgProfilePic.image = img

        dismiss(animated: true, completion: nil)
    }
}

