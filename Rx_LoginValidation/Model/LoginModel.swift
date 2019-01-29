//
//  LoginModel.swift
//  Rx_LoginValidation
//
//  Created by Munna on 27/01/19.
//  Copyright © 2019 GravetyTech. All rights reserved.
//

import Foundation

class LoginModel {
    
    var email = ""
    var password = ""
    
    init(email : String, password: String) {
        self.email = email
        self.password = password
    }
}
