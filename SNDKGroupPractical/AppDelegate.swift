//
//  AppDelegate.swift
//  SNDKGroupPractical
//
//  Created by Manish Sharma on 21/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        userRegistered()
        return true
    }


    // MARK:- Auto login
    // if user is registered then navigate Welcome screen directly
    func userRegistered() {
        // auto login and navigate to main screen if login once
        let loginStatus = UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.isLogin)

        if loginStatus == true {
            self.navigateToScreen(identifier: "WelcomeNavigation")
        } else {
            navigateToScreen(identifier: "LoginViewController")
        }
    }
    
    func navigateToScreen(identifier: String) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }

}

