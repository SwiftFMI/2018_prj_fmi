//
//  LoginViewController.swift
//  FMI App
//
//  Created by Yalishanda on 3.01.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet var roundedViewsCollection: [UIView]!
    
    @IBOutlet weak var errorLabelLogin: UILabel!
    
    let viewsCornerRadius : CGFloat = 30
    var selectedSectionId: Int? = nil
    
    var savedEmail: String? = nil
    var savedPassword: String? = nil
    var savedUid: String? = nil
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in roundedViewsCollection {
            view.layer.cornerRadius = viewsCornerRadius
        }
        
        fetchUserInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailField.text = savedEmail
        passwordField.text = savedPassword
    }
    
    func fetchUserInfo() {
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
    
    
    func saveNewUser (email: String, password: String, uid: String) {
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
    
    
    func updateDatabase() {
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
    
    @IBAction func didTapToEndInput(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return identifier != "loginSuccessfulSegue"
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
            
            
            if let lastUid = self?.savedUid {
                if user.user.uid != lastUid {
                    self?.savedEmail = email
                    self?.savedPassword = password
                    self?.savedUid = user.user.uid
                    self?.updateDatabase()
                }
            } else {
                self?.saveNewUser(email: email, password: password, uid: user.user.uid)
            }
            
            self?.performSegue(withIdentifier: "loginSuccessfulSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSuccessfulSegue" {
            if let destinationViewController = segue.destination as? CoursesViewController {
                destinationViewController.selectedSectionId = self.selectedSectionId
            }
        }
    }
}
