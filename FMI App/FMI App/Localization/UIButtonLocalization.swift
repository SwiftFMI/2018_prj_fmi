//
//  UIButtonLocalization.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    @IBInspectable var localizedText: String! {
        set(value) {
            setTitle(value?.localized, for: .normal)
        }
        get {
            return titleLabel?.text
        }
    }
}
