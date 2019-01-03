//
//  RegisterViewController.swift
//  FMI App
//
//  Created by Yalishanda on 3.01.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordRepeatField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let viewsCornerRadius : CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputFieldsCollection : [UITextField] =
        [
            emailField,
            passwordField,
            passwordRepeatField
        ]
        
        for textField in inputFieldsCollection {
            textField.superview?.layer.cornerRadius = viewsCornerRadius
        }
        
        registerButton.superview?.layer.cornerRadius = viewsCornerRadius
    }
    
    @IBAction func didTapToEndUserInput(_ sender: Any) {
        view.endEditing(true)
    }
    
}
