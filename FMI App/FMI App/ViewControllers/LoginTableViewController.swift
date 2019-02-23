//
//  LoginTableViewController.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

class LoginTableViewController: InputTableViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    var selectedSectionId: Int? = nil

    var savedEmail: String? = nil
    var savedPassword: String? = nil
    var savedUid: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUserInfo()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        emailField.text = savedEmail
        passwordField.text = savedPassword
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSuccessfulSegue" {
            if let destinationViewController = segue.destination as? CoursesViewController {
                destinationViewController.selectedSectionId = self.selectedSectionId
            }
        }
    }

    // MARK: - Private

    private func fetchUserInfo() {
        if let user = DatabaseHelper.shared.fetchUserInfo() {
            savedUid = user.id
            savedEmail = user.email
            savedPassword = user.password
        }
    }


    private func saveUser(email: String, password: String, uid: String) {
        DatabaseHelper.shared.saveUser(email: email, password: password, uid: uid)
    }


    private func updateDatabase() {
        DatabaseHelper.shared.updateUser(email: savedEmail,
                                         id: savedUid,
                                         password: savedPassword)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return identifier != "loginSuccessfulSegue"
    }

    // MARK: - IBAction

    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func onTapLoginWithEmail(_ sender: Any) {
        guard let email = emailField.text,
            let password = passwordField.text,
            !email.isEmpty,
            !password.isEmpty else {
                AlertPresenter.showAlert(from: self, with: "empty_fields".localized)
                return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self]
            (authDataResult, error) in
            guard let strongSelf = self else {
                return
            }
            guard let user = authDataResult else {
                AlertPresenter.showAlert(from: strongSelf, with: "invalid_credentials".localized)
                return
            }


            if let lastUid = strongSelf.savedUid {
                if user.user.uid != lastUid {
                    strongSelf.savedEmail = email
                    strongSelf.savedPassword = password
                    strongSelf.savedUid = user.user.uid
                    strongSelf.updateDatabase()
                }
            } else {
                strongSelf.saveUser(email: email, password: password, uid: user.user.uid)
            }

            strongSelf.performSegue(withIdentifier: "loginSuccessfulSegue", sender: nil)
        }
    }
}
