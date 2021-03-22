//
//  UIAlertController+Extensions.swift
//  SNDKGroupPractical
//
//  Created by Manish Sharma on 21/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
   
    func presentAlert(withTitle title: String, message : String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let OKAction = UIAlertAction(title: "OK", style: .default)
      alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}


