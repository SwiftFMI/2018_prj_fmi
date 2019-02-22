//
//  RegistrationTableViewController.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

class RegistrationTableViewController: InputTableViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordRepeatField: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    let viewsCornerRadius : CGFloat = 30

    let PASSWD_LEN_MIN = 8
    let PASSWD_LEN_MAX = 64


    @IBAction func onTapRegisterButton(_ sender: Any) {
        if validateData() {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) {
                [weak self]
                (authResult, error) in
                guard let user = authResult?.user else {
//                    self?.errorLabel.text = "Потребителят не може да бъде създаден!"
                    return
                }
                self?.navigationController?.popViewController(animated: true)

                if let loginVC = self?.navigationController?.topViewController as? LoginTableViewController {
                    loginVC.savedUid = user.uid
                    loginVC.savedEmail = user.email
                    loginVC.savedPassword = self?.passwordField.text
                }
            }
        }
    }

    func validateData() -> Bool {
        guard let email = emailField.text, let password = passwordField.text, let passwordRepeated = passwordRepeatField.text else {
//            errorLabel.text = "Полетата трябва да са попълнени!"
//            errorLabel.alpha = 1
            return false
        }

        var errorMessage: String = ""

        if !email.isValidEmail() {
            errorMessage = "Въведеният имейл е невалиден!"
        } else if password.count < PASSWD_LEN_MIN {
            errorMessage = "Паролата е твърде кратка!"
        } else if password.count > PASSWD_LEN_MAX {
            errorMessage = "Паролата е твърде дълга!"
        } else if password != passwordRepeated {
            errorMessage = "Паролите не съвпадат!"
        }

//        errorLabel.text = errorMessage
//        errorLabel.alpha = errorMessage == "" ? 0 : 1
        return errorMessage == ""

    }

    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
