//
//  NavigationItemLocalization.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    @IBInspectable var localizedTitle: String! {
        set(value) {
            title = value.localized
        }
        get {
            return title
        }
    }
}

