//
//  ViewController.swift
//  SNDKGroupPractical
//
//  Created by Manish Sharma on 21/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: LoadingButton!
    
    private let apiUtility = HttpUtility.shared
    let defaults = UserDefaults.standard
    var window: UIWindow?

    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
   
    // MARK: - Button Actions
    @IBAction func loginAction(_ sender: UIButton) {
        
        if txtUserName.text != "" || txtPassword.text != "" {
            DispatchQueue.main.async(execute: {
                self.showActivityLoader()
            })
            self.checkLogin()
        } else {
            self.presentAlert(withTitle: "Blank input", message: "Username/password is blank")
        }
       
    }
    
    
    // MARK: - Custom methods
    private func checkLogin() {
        let urlRequest = createUrlRequest()
        
        apiUtility.userLogin(urlRequest: urlRequest) { (userResponse) in
            
            if userResponse.status == "ok" {
                // login success
                if let userData = userResponse.response?.table1 {
                    if userData.count > 0 {
                        if let userDisplayName = userData[0].userdisplayname {
                            self.removeActivityLoader()
                            if userDisplayName != "" {
                                // Userdefaults to store name
                                self.defaults.set(userDisplayName, forKey: Constants.UserDefaultsKeys.displayName)
                                self.defaults.set(true, forKey: Constants.UserDefaultsKeys.isLogin)
                                DispatchQueue.main.async {
                                    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "WelcomeNavigation")
                                    self.window = UIWindow(frame: UIScreen.main.bounds)
                                    self.window?.rootViewController = initialViewController
                                    self.window?.makeKeyAndVisible()
                                }
                            }
                        }
                    }
                }
            } else if userResponse.status == "error" {
                // wrong username and password
                self.removeActivityLoader()
                DispatchQueue.main.async {
                    self.presentAlert(withTitle: "Invalid credentials", message: userResponse.message ?? "Invalid credentails entered")
                }
            } else {
                // default error
                self.removeActivityLoader()
                DispatchQueue.main.async {
                    self.presentAlert(withTitle: "Issue!!", message: "Unknown issue occured")
                }
            }
        }
    }
    
    func createUrlRequest() -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: EndPoints.loginUser)!)
         urlRequest.httpMethod = "post"
         let userData: [String : Any] = [Constants.LoginParam.username: self.txtUserName.text!,
                                         Constants.LoginParam.password: self.txtPassword.text!,
                                         Constants.LoginParam.gmtOffset: "5.50",
                                         Constants.LoginParam.deviceInfo: Constants.staticDeviceInfo.staticDeviceInfo]
         
         do {
             let requestBody = try JSONSerialization.data(withJSONObject: userData, options: .prettyPrinted)
             urlRequest.httpBody = requestBody
             urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
         } catch let error {
             debugPrint(error.localizedDescription)
         }
        return urlRequest
    }
    
    // MARK: - Activity indicator
    func showActivityLoader() {
        DispatchQueue.main.async(execute: {
            self.view.isUserInteractionEnabled = false
            self.btnLogin.showLoading()
        })
    }
    
    func removeActivityLoader() {
        DispatchQueue.main.async(execute: {
            self.view.isUserInteractionEnabled = true
            self.btnLogin.hideLoading()
        })
    }
    

}
