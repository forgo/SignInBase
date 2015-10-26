//
//  AuthUser.swift
//  SignInBase
//
//  Created by Elliott Richerson on 10/25/15.
//  Copyright © 2015 Elliott Richerson. All rights reserved.
//

import UIKit

struct AuthUser {

    var userId: String
    var accessToken: String
    var name: String
    var email: String
    var pic: UIImage
    
    init() {
        self.userId = ""
        self.accessToken = ""
        self.name = ""
        self.email = ""
        self.pic = UIImage()
    }
    
    init(userId: String, accessToken: String, name: String, email: String, pic: UIImage) {
        self.userId = userId
        self.accessToken = accessToken
        self.name = name
        self.email = email
        self.pic = pic
    }
    
    init(authUser: AuthUser) {
        self.userId = authUser.userId
        self.accessToken = authUser.accessToken
        self.name = authUser.name
        self.email = authUser.email
        self.pic = authUser.pic
    }
}