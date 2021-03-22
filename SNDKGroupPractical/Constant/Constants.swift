//
//  HttpUtility.swift
//  SNDKGroupPractical
//
//  Created by Manish Sharma on 21/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//


import Foundation

struct Constants {
 
    struct LoginParam {
        static let username = "username"
        static let password = "password"
        static let gmtOffset = "gmtoffset"
        static let deviceInfo = "deviceinfo"
        static let deviceUUID = "deviceimieuuid"
        static let deviceType = "devicetype"
        static let apns = "APNS"
        static let locationInfo = "locationinfo"
        static let deviceId = "deviceid"
        static let voidDeviceId = "voipdeviceid"
    }
    
    struct staticDeviceInfo {
        static let staticDeviceInfo = "{\"deviceimieuuid\":\"003CFEEC-36E7-48EA-8C53-9A42F2A3F8AD\",\"devicetype\":\"APNS\",\"locationinfo\":\"{}\",\"deviceid\":\"\",\"voipdeviceid\":\"\"}"
    }
    
    struct UserDefaultsKeys {
        static let isLogin = "isUserLoggedIn"
        static let displayName = "displayName"
    }
    
}

