//
//  AuthGoogle.swift
//  SignInBase
//
//  Created by Elliott Richerson on 10/24/15.
//  Copyright © 2015 Elliott Richerson. All rights reserved.
//

import Foundation

// MARK: - AuthGoogle
class AuthGoogle: NSObject, AuthAppMethod, GIDSignInDelegate, GIDSignInUIDelegate  {
    
    // Singleton
    static let sharedInstance = AuthGoogle()
    private override init() {
        self.signIn = GIDSignIn.sharedInstance()
        self.signIn.shouldFetchBasicProfile = true
    }
    
    // Auth method classes invokes AuthDelegate methods to align SDK differences
    var delegate: AuthDelegate?
    
    private var signIn: GIDSignIn
    private var signInButton: GIDSignInButton!
    
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
    
    // MARK: - GIDSignInDelegate
    /* -------------------------------------------------------------------------
    Note: The Sign-In SDK automatically acquires access tokens, but the
    access tokens will be refreshed only when you call signIn or
    signInSilently. To explicitly refresh the access token, call the
    refreshAccessTokenWithHandler: method. If you need the access token and
    want the SDK to automatically handle refreshing it, you can use the
    getAccessTokenWithHandler: method.
    
    Important: If you need to pass the currently signed-in user to a backend
    server, send the user's ID token to your backend server and validate the
    token on the server.
    */
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            // TODO: Can we leverage user.serverAuthCode for token validation?
            let userId: String = user.userID                        // For client-side use only!
            let accessToken: String = user.authentication.idToken   // Safe to sendn to the server
            let name: String = user.profile.name
            let email: String = user.profile.email
            
            var pic: UIImage = UIImage()
            if(user.profile.hasImage) {
                // TODO: Profile pic retrieval is synchronous, do we care for login?
                let picURL: NSURL = user.profile.imageURLWithDimension(256)
                let picData: NSData = NSData(contentsOfURL: picURL)!
                pic = UIImage(data: picData)!
            }
            else {
                pic = UIImage(named: "defaultProfilePic")!
            }
            
            let authUser = AuthUser(userId: userId, accessToken: accessToken, name: name, email: email, pic: pic)
            self.delegate?.loginSuccess(.Google, user: authUser)
        } else {
            self.delegate?.loginError(.Google, error: error)
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        if (error == nil) {
            self.delegate?.didLogout(.Google)
        }
        else {
            self.delegate?.didFailToLogout(.Google, error: error)
        }
        
    }
    
    // MARK: - GIDSignInUIDelegate
    /* -------------------------------------------------------------------------
    Implement these methods only if the GIDSignInUIDelegate is not a subclass of
    UIViewController.
    
    Stop the UIActivityIndicatorView animation that was started when the user
    pressed the Sign In button
    */
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
//        myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
//            self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
//            self.dismissViewControllerAnimated(true, completion: nil)
    }
        
}