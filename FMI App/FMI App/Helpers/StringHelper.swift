//
//  StringHelper.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation

class StringHelper {

    private struct Regex {
        static let emailPattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    }

    static func isValid(email: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: Regex.emailPattern,
                                             options: .caseInsensitive)
        return regex?.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
    }
}

