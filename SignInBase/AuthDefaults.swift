//
//  AuthDefaults.swift
//  SignInBase
//
//  Created by Elliott Richerson on 10/25/15.
//  Copyright © 2015 Elliott Richerson. All rights reserved.
//

import Foundation

class AuthDefaults {
    
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
//    var user: AuthUser {
//        get {
//            if let userDefaults = defaults.stringForKey("userDefaultsAuthUserKey") {
//                if let authUser = AuthUser(
//            }
//        }
//    }
}

//    var loginMethod : LoginMethod {
//
//        get {
//            let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
//            if let method = defaults.stringForKey(userDefaultsLoginMethodKey) {
//                if let loginMethod = LoginMethod(rawValue: method) {
//                    return loginMethod
//                }
//            }
//            return LoginMethod.NotLoggedIn
//        }
//        set {
//            let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
//            defaults.setValue(newValue.rawValue, forKey: userDefaultsLoginMethodKey)
//        }
//    }
//
//    var accessToken : String? {
//
//        get {
//            let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
//            if let token = defaults.stringForKey(userDefaultsAppTokenKey) {
//                return token
//            }
//            return nil
//        }
//        set {
//            let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
//            defaults.setValue(newValue, forKey: userDefaultsAppTokenKey)
//        }
//    }
//