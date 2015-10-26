//
//  LoginViewController.swift
//  SignInBase
//
//  Created by Elliott Richerson on 10/24/15.
//  Copyright © 2015 Elliott Richerson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var buttonSignInFacebook: UIButton!
    @IBOutlet weak var buttonSignInGoogle: GIDSignInButton!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* GOOGLE SIGN-IN UI */
        /* -----------------------------------------------------------------
           Note: When users silently sign in, the Sign-In SDK automatically 
           acquires access tokens and automatically refreshes them when 
           necessary. If you need the access token and want the SDK to 
           automatically handle refreshing it, you can use the 
           getAccessTokenWithHandler: method. To explicitly refresh the 
           access token, call the refreshAccessTokenWithHandler: method.
        */
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: User Actions
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        if(sender as! NSObject == self.buttonSignInGoogle) {
            GIDSignIn.sharedInstance().signIn()
        }
        self.performSegueWithIdentifier("SegueLoginToHome", sender: self);
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "SegueLoginToHome") {
            let homeVC: HomeViewController = segue.destinationViewController as! HomeViewController
            homeVC.loginService = "Google"
        }
    }
    
    @IBAction func prepareForUnwindToLogin(segue: UIStoryboardSegue) {
        if (segue.identifier == "UnwindSegueHomeToLogin") {
            
        }
    }

}

