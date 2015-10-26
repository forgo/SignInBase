//
//  LoginViewController.swift
//  SignInBase
//
//  Created by Elliott Richerson on 10/24/15.
//  Copyright © 2015 Elliott Richerson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AuthUIDelegate {

    @IBOutlet weak var buttonSignInFacebook: UIButton!
    @IBOutlet weak var buttonSignInGoogle: GIDSignInButton!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        Auth.sharedInstance.authUIDelegate = self
        Auth.sharedInstance.loginViewController = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: User Actions
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        if(sender as! NSObject == self.buttonSignInGoogle) {
            Auth.sharedInstance.login(.Google)
        }
        else if(sender as! NSObject == self.buttonSignInFacebook) {
            Auth.sharedInstance.login(.Facebook)
        }
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "SegueLoginToHome") {
            let homeVC: HomeViewController = segue.destinationViewController as! HomeViewController
            homeVC.loginService = Auth.sharedInstance.currentAuthMethod.rawValue
        }
    }
    
    @IBAction func prepareForUnwindToLogin(segue: UIStoryboardSegue) {
        if (segue.identifier == "UnwindSegueHomeToLogin") {
            
        }
    }
    
    // MARK: - AuthUIDelegate
    
    func authUILoginDidSucceed() {
        self.performSegueWithIdentifier("SegueLoginToHome", sender: self)
    }
    
    func authUILoginDidCancel() {
        print("Login was cancelled")
    }
    
    func authUILoginDidError() {
        print("Login was unsuccessful")
    }
    

}

