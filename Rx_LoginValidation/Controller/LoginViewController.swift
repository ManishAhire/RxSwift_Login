//
//  LoginViewController.swift
//  Rx_LoginValidation
//
//  Created by Munna on 27/01/19.
//  Copyright © 2019 GravetyTech. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    //MARK:- Variables
    let disposeBag = DisposeBag() // Bag of disposables to release them when view is being deallocated
    let loginVM = LoginViewModel()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtEmail
            .rx.text // Observable Property
            .orEmpty // Make it non-optional
            .bind(to: loginVM.email) // Connecting every new value with the variable
            .disposed(by: disposeBag) // Release txtEmail when view is being deallocated
        
        
        txtPassword
            .rx.text // Observable Property
            .orEmpty // Make it non-optional
            .bind(to: loginVM.password) // Connecting every new value with the variable
            .disposed(by: disposeBag) // Release txtPassword when view is being deallocated
        
        
        btnLogin
            .rx.tap // Observable Property
            .do(onNext :{[unowned self] in // On next event dismiss the keyboard
                self.view.endEditing(true)
            })
            .subscribe(onNext: {[unowned self] in // Subscribe to every new value
                
                if self.loginVM.validation() {
                    self.loginVM.callLoginAPI()
                } else {
                    self.showAlert(msg: self.loginVM.errorMsg.value)
                }
            })
            .disposed(by: disposeBag) // Release btnLogin when view is being deallocated
        
    }
    
    //MARK:- Show Alert
    func showAlert(msg : String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
