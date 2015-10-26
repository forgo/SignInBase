//
//  AuthCustom.swift
//  SignInBase
//
//  Created by Elliott Richerson on 10/25/15.
//  Copyright © 2015 Elliott Richerson. All rights reserved.
//

import Foundation

// MARK: - AuthCustom
class AuthCustom: NSObject, AuthAppMethod {
    
    // Singleton
    static let sharedInstance = AuthCustom()
    private override init() {}
    
    // Auth method classes invokes AuthDelegate methods to align SDK differences
    var delegate: AuthDelegate?
    
    // MARK: - AuthAppMethod Protocol
    func configure(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        self.signIn.delegate = self
        return true
    }
    
    func openURL(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return self.signIn.handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func isLoggedIn() -> Bool {
        if(self.signIn.currentUser != nil) {
            return true
        }
        else {
            return false
        }
    }
    
    func login(fromViewController: UIViewController) {
        self.signIn.signIn();
        // TODO: Does the signInButton belong here or in a Login VC?
        // UI delegate method impl not needed if Login VC adopts GIDSignInUIDelegate
        //self.signInButton.sendActionsForControlEvents(.TouchUpInside)
    }
    
    func logout() {
        // Revokes authentication, token removed from keychain
        self.signIn.signOut()
        self.signIn.disconnect()
    }
}