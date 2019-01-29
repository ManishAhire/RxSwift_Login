//
//  LoginViewModel.swift
//  Rx_LoginValidation
//
//  Created by Munna on 27/01/19.
//  Copyright © 2019 GravetyTech. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel {
    
    var email = Variable<String>("")
    var password = Variable<String>("")
    var errorMsg = Variable<String>("")
    
    func validation() -> Bool {
        
        if email.value.isEmpty {
            errorMsg.value = "Please enter email"
            return false
        } else if !(validateEmail()) {
            errorMsg.value = "Please enter valid email"
            return false
        } else if password.value.isEmpty {
            errorMsg.value = "Please enter password"
            return false
        }
        
        return true
    }
    
    func validateEmail() -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email.value)
    }
    
    func callLoginAPI() {
        
        let loginModel = LoginModel(email: email.value, password: password.value)
        print(loginModel.email, loginModel.password)
    }
    
}
