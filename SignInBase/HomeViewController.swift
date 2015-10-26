//
//  HomeViewController.swift
//  SignInBase
//
//  Created by Elliott Richerson on 10/24/15.
//  Copyright © 2015 Elliott Richerson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var buttonSignOut: UIButton!
    
    var loginService: String = "BabySync"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.labelStatus.text = self.loginService;
    }
    
    override func viewDidAppear(animated: Bool) {
        self.labelStatus.text = self.loginService
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: User Actions
    
    @IBAction func didTapSignOut(sender: AnyObject) {
        if(sender as! NSObject == self.buttonSignOut) {
            Auth.sharedInstance.logout()
        }
        self.performSegueWithIdentifier("UnwindSegueHomeToLogin", sender: self);
    }

    
    // MARK: - Navigation

    

}
