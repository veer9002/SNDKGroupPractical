//
//  WelcomeViewController.swift
//  SNDKGroupPractical
//
//  Created by Manish Sharma on 21/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK:- Properties
    @IBOutlet weak var lblUserName: UILabel!
    let defaults = UserDefaults.standard
    var window: UIWindow?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userDisplayName = defaults.value(forKey: Constants.UserDefaultsKeys.displayName) as? String {
            lblUserName.text = userDisplayName
        }
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: Button Action
    @IBAction func logoutAction(_ sender: UIButton) {
        //Batchdelete
        PersistentStorage.shared.deleteAllRecords()
//        defaults.removeObject(forKey: Constants.UserDefaultsKeys.displayName)
        self.defaults.set(false, forKey: Constants.UserDefaultsKeys.isLogin)
       
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    

}
