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

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
        let request = User.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        do {
            let result = try context.fetch(request)
            if result.count > 1 {
                // should be only 1 entry in the entity,
                // we want to auto load it into the text fields
                for data in result as! [NSManagedObject] {
                    savedEmail = data.value(forKey: "email") as? String
                    savedPassword = data.value(forKey: "password") as? String
                    savedUid = data.value(forKey: "uid") as? String
                }
            }
        } catch {
            print("error fetching")
        }
    }


    private func saveNewUser (email: String, password: String, uid: String) {
        savedEmail = email
        savedPassword = password
        savedUid = uid

        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)

        newUser.setValue(email, forKey: "email")
        newUser.setValue(password, forKey: "password")
        newUser.setValue(uid, forKey: "uid")

        do {
            try context.save()
        } catch {
            print("could not save context after user insertion")
        }
    }


    private func updateDatabase() {
        let request = User.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        do {
            let result = try context.fetch(request)
            if result.count > 1 {
                // should be only 1 entry in the entity,
                for data in result as! [NSManagedObject] {
                    data.setValue(savedEmail, forKey: "email")
                    data.setValue(savedPassword, forKey: "password")
                    data.setValue(savedUid, forKey: "uid")
                }
            }
        } catch {
            print("error fetching")
        }
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
                strongSelf.saveNewUser(email: email, password: password, uid: user.user.uid)
            }

            strongSelf.performSegue(withIdentifier: "loginSuccessfulSegue", sender: nil)
        }
    }
}
