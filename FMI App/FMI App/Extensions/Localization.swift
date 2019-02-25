//
//  Localization.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
extension String: Localizable {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    public func localizedString(with arguments: [CVarArg]) -> String {
        return String(format: localized, arguments: arguments)
    }
}

protocol Localizable {
    var localized: String { get }
}
