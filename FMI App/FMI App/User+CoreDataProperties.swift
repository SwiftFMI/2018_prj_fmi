//
//  User+CoreDataProperties.swift
//  FMI App
//
//  Created by Alexander on 12.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var uid: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?

}
