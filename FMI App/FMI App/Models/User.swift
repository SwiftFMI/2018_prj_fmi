//
//  User.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation

struct UserModel {
    let email: String
    let password: String
    let id: String

    init(email: String, password: String, id: String) {
        self.email = email
        self.password = email
        self.id = id
    }
}
