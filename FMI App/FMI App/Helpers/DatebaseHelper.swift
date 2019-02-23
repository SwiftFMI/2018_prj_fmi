//
//  DatebaseHelper.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseHelper {

    static let shared = DatabaseHelper()

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private init(){}

    func fetchUserInfo() -> UserModel? {
        let request = User.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        do {
            let result = try context.fetch(request)
            if result.count > 1 {
                // should be only 1 entry in the entity,
                // we want to auto load it into the text fields
                for data in result as! [NSManagedObject] {
                    if let savedEmail = data.value(forKey: "email") as? String,
                        let savedPassword = data.value(forKey: "password") as? String,
                        let savedUid = data.value(forKey: "uid") as? String {
                        return UserModel(email: savedEmail, password: savedPassword, id: savedUid)
                    }
                }
            }
        } catch {
            print("error fetching")
            return nil
        }
        return nil
    }

    func saveUser(email: String, password: String, uid: String) {
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

    func updateUser(email: String?, id: String?, password: String?) {
        guard let email = email, let id = id, let password = password else {
            return
        }
        let request = User.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        do {
            let result = try context.fetch(request)
            if result.count > 1 {
                // should be only 1 entry in the entity,
                for data in result as! [NSManagedObject] {
                    data.setValue(email, forKey: "email")
                    data.setValue(password, forKey: "password")
                    data.setValue(id, forKey: "uid")
                }
            }
        } catch {
            print("error fetching")
        }
    }
}
