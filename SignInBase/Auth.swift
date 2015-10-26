//
//  Auth.swift
//  SignInBase
//
//  Created by Elliott Richerson on 10/24/15.
//  Copyright © 2015 Elliott Richerson. All rights reserved.
//

import UIKit

class Auth: NSObject, AuthDelegate {
    
    // Singleton
    static let sharedInstance = Auth()
    private override init() {}
    
    // Auth Method Helpers
    var google: AuthGoogle = AuthGoogle.sharedInstance
    var facebook: AuthFacebook = AuthFacebook.sharedInstance
    var custom: AuthCustom = AuthCustom.sharedInstance
    
    // MARK: - AuthDelegate
    
    func loginSuccess(method: AuthMethodType, user: AuthUser) {
        switch method {
        case .Google:
            print("Google login success.")
        case .Facebook:
            print("Facebook login success.")
        case .Custom:
            print("Custom login success.")
        }
        print("Authenticated user = ", user)
        
        // If we logged in via something besides our own service (FB/Google)
        // we don't care about creating a User in our database
        // they only need to be referenced by a unique email constraint

        // If we logged in via our own service
        // we can be sure there is a valid User in our database
        
        
        // Validate token on server, with the appropriate method
        
        
    }
    
    func loginCancel(method: AuthMethodType) {
        switch method {
        case .Google:
            print("Google login cancelled.")
        case .Facebook:
            print("Facebook login cancelled.")
        case .Custom:
            print("Custom login cancelled.")
        }
    }

    func loginError(method: AuthMethodType, error: NSError?) {
        switch method {
        case .Google:
            print("Google login error.")
        case .Facebook:
            print("Facebook login error.")
        case .Custom:
            print("Custom login error.")
        }
        print("\(error?.localizedDescription)")
    }
    
    func didLogout(method: AuthMethodType) {
        switch method {
        case .Google:
            print("Google logout.")
        case .Facebook:
            print("Facebook logout.")
        case .Custom:
            print("Custom logout.")
        }
    }
    
    func didFailToLogout(method: AuthMethodType, error: NSError?) {
        switch method {
        case .Google:
            print("Google logout failure.")
        case .Facebook:
            print("Google logout failure.")
        case .Custom:
            print("Google logout failure.")
        }
        print("\(error?.localizedDescription)")
    }

    // MARK: - Auth Helpers
    
    func login(method: AuthMethodType, fromViewController: UIViewController) {
        switch method {
        case .Google:
            print("Attempting Google login.")
            if(self.google.isLoggedIn()) {
                print("Already logged in to Google.")
            }
            else {
                self.google.login(fromViewController)
            }
        case .Facebook:
            print("Attempting Facebook login.")
            if(self.facebook.isLoggedIn()) {
                print("Already logged in to Facebook.")
            }
            else {
                self.facebook.login(fromViewController)
            }
        case .Custom:
            print("Attempting Custom login.")
            if(self.custom.isLoggedIn()) {
                print("Already logged in to Custom.")
            }
            else {
                self.custom.login(fromViewController)
            }
        }
    }
    
    func logout(method: AuthMethodType) {
        switch method {
        case .Google:
            if(self.google.isLoggedIn()) {
                print("Attempting Google logout.")
                self.google.logout()
            }
            else {
                print("Already logged out of Google.")
            }
        case .Facebook:
            if(self.facebook.isLoggedIn()) {
                print("Attempting Facebook logout.")
                self.facebook.logout()
            }
            else {
                print("Already logged out of Facebook.")
            }
        case .Custom:
            if(self.custom.isLoggedIn()) {
                print("Attempting Custom logout.")
                self.custom.logout()
            }
            else {
                print("Already logged out of Custom.")
            }
        }
    }







}
