//
//  UITextFieldLocalization.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    @IBInspectable var localizedPlaceholder: String! {
        set(value) {
            placeholder = value?.localized
        }
        get {
            return placeholder
        }
    }
}
