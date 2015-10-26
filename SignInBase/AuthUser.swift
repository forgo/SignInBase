//
//  AuthUser.swift
//  SignInBase
//
//  Created by Elliott Richerson on 10/25/15.
//  Copyright © 2015 Elliott Richerson. All rights reserved.
//

import Locksmith
import UIKit

struct AuthUser: CreateableSecureStorable,
                 ReadableSecureStorable,
                 DeleteableSecureStorable,
                 GenericPasswordSecureStorable {

    var userId: String
    var accessToken: String
    var name: String
    var email: String
    var pic: UIImage
    
    // Required by GenericPasswordSecureStorable
    var service: String
    var account: String { return email }
    
    // Required by CreateableSecureStorable
    var data: [String: AnyObject] {
        return [
            "userId": userId,
            "accessToken": accessToken,
            "name": name,
            "email": email,
            "pic": pic
        ]
    }
    
    init() {
        self.service = AuthDefaults.sharedInstance.authMethod
        self.userId = ""
        self.accessToken = ""
        self.name = ""
        self.email = AuthDefaults.sharedInstance.email
        self.pic = AuthConstant.Default.ProfilePic
    }
    
    init(service: AuthMethodType, userId: String, accessToken: String, name: String, email: String, pic: UIImage) {
        self.service = service.rawValue
        self.userId = userId
        self.accessToken = accessToken
        self.name = name
        self.email = email
        self.pic = pic
    }
}