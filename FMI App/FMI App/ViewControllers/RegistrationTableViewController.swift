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

    private struct Password {
        static let min = 8
        static let max = 64
    }

    // MARK: - IBOutlet

    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var passwordRepeatField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!

    // MARK: - Private

    private func isDataCorrect() -> Bool {
        guard let email = emailField.text,
            let password = passwordField.text,
            let confirmPassword = passwordRepeatField.text,
            !email.isEmpty,
            !password.isEmpty,
            !confirmPassword.isEmpty else {
                AlertPresenter.showAlert(from: self, with: "empty_fields".localized)
                return false
        }
        if !StringHelper.isValid(email: email) {
            AlertPresenter.showAlert(from: self, with: "invalid_email".localized)
            return false
        } else if password.count < Password.min {
            AlertPresenter.showAlert(from: self, with: "short_password".localized)
            return false
        } else if password.count > Password.max {
            AlertPresenter.showAlert(from: self, with: "long_password")
            return false
        } else if password != confirmPassword {
            AlertPresenter.showAlert(from: self, with: "passwords_dont_match")
            return false
        }
        return true
    }

    // MARK: - IBAction

    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func onTapRegisterButton(_ sender: Any) {
        guard isDataCorrect() else {
            return
        }
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) {
            [weak self]
            (authResult, error) in
            guard let strongSelf = self else {
                return
            }
            if let error = error {
                AlertPresenter.showAlert(from: strongSelf, with: error.localizedDescription)
                return
            }
            guard let user = authResult?.user else {
                return
            }
            strongSelf.navigationController?.popViewController(animated: true)

            if let loginVC = strongSelf.navigationController?.topViewController as? LoginTableViewController {
                loginVC.savedUid = user.uid
                loginVC.savedEmail = user.email
                loginVC.savedPassword = self?.passwordField.text
            }
        }
    }
}
