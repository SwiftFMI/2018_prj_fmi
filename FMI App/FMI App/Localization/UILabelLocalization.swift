//
//  UILabelLocalization.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    @IBInspectable var localizedText: String! {
        set(value) {
            text = value?.localized
        }
        get {
            return text
        }
    }
}
