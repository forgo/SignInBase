//
//  AuthAppMethod.swift
//  SignInBase
//
//  Created by Elliott Richerson on 10/25/15.
//  Copyright © 2015 Elliott Richerson. All rights reserved.
//

import UIKit

// MARK: - AuthAppMethod
protocol AuthAppMethod {
    
    // Configuration to be called in app's didFinishLaunchingWithOptions
    func configure(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    
    // Each auth method should validate URLs sent to the app
    // true if valid URL for implementing auth method,
    // false if invalid URL
    func openURL(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool
    
    // Each auth method should be able to determine their logged-in state
    func isLoggedIn() -> Bool
    
    // Each auth method should have a way to initiate login
    func login(fromViewController: UIViewController)
    
    // Each auth method should have a way to logout
    func logout()
    
}