//
//  UITextField+Extension.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
import UIKit

private var associationKeyNextField: UInt8 = 0

extension UITextField {
//    @IBInspectable var localizedPlaceholder: String! {
//        set(value) {
//            placeholder = value?.localized
//        }
//        get {
//            return placeholder
//        }
//    }

    @IBOutlet public var nextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &associationKeyNextField) as? UITextField
        }
        set(newField) {
            objc_setAssociatedObject(self, &associationKeyNextField, newField, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
