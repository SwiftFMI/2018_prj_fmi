//
//  LoginViewController.swift
//  FMI App
//
//  Created by Yalishanda on 3.01.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet var roundedViewsCollection: [UIView]!
    
    @IBOutlet weak var errorLabelLogin: UILabel!
    
    let viewsCornerRadius : CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in roundedViewsCollection {
            view.layer.cornerRadius = viewsCornerRadius
        }
        
        // TODO: automatically load user data if available; integration with Core Data
    }
    
    @IBAction func didTapToEndInput(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func onTapLoginWithEmail(_ sender: Any) {
        guard let email = emailField.text, let password = passwordField.text
            else {
            errorLabelLogin.text = "Моля попълнете полетата за влизане чрез имейл!"
            errorLabelLogin.alpha = 1
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self]
            (authDataResult, error) in
            guard let user = authDataResult else {
                self?.errorLabelLogin.text = "Невалидни имейл или парола!"
                self?.errorLabelLogin.alpha = 1
                return
            }
            
            self?.errorLabelLogin.alpha = 0
            // TODO: save data
            // TODO: fix segue
        }
    }
}
