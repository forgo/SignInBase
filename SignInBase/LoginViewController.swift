//
//  LoginViewController.swift
//  SignInBase
//
//  Created by Elliott Richerson on 10/24/15.
//  Copyright © 2015 Elliott Richerson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AuthUIDelegate, UITextFieldDelegate {

    @IBOutlet weak var buttonLoginFacebook: UIButton!
    @IBOutlet weak var buttonLoginGoogle: UIButton!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Auth Helper
        Auth.sharedInstance.authUIDelegate = self
        Auth.sharedInstance.loginViewController = self
        
        // Hide Interface Until We Know Logged In
        self.view.hidden = true
        
        // Login Text Field Configuration
        self.textFieldEmail.delegate = self
        self.textFieldPassword.delegate = self
        self.resetPlaceholder(self.textFieldEmail, placeholder: "email")
        self.resetPlaceholder(self.textFieldPassword, placeholder: "password")
    }
    
    func resetPlaceholder(textField: UITextField, placeholder: String) {
        let placeholderTextColor: UIColor = UIColor.whiteColor()
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName:placeholderTextColor])
    }

    override func viewDidAppear(animated: Bool) {
        // Skip Login If Already Logged In
        if(Auth.sharedInstance.isLoggedIn()) {
            self.performSegueWithIdentifier("SegueLoginToHome", sender: self)
        }
        else {
            self.view.hidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: User Actions
    
    @IBAction func didTapSignIn(sender: UIButton) {
        if(sender == self.buttonLoginGoogle) {
            Auth.sharedInstance.login(.Google)
        }
        else if(sender == self.buttonLoginFacebook) {
            Auth.sharedInstance.login(.Facebook)
        }
        else if(sender == self.buttonLogin) {
            Auth.sharedInstance.login(.Custom)
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
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField.text?.characters.count == 0) {
            textField.placeholder = nil
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if(textField == self.textFieldEmail) {
            if(textField.text?.characters.count == 0) {
                self.resetPlaceholder(textField, placeholder: "email")
            }
        }
        else if(textField == self.textFieldPassword) {
            if(textField.text?.characters.count == 0) {
                self.resetPlaceholder(textField, placeholder: "password")
            }
        }
    }
    
}

