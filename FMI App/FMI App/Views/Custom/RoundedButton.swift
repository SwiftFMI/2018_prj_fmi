//
//  RoundedButton.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class RoundedButton: UIButton {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupCornerRadius()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCornerRadius()
    }

    // MARK: Private

    private func setupCornerRadius() {
        layer.cornerRadius = bounds.height/2
    }
}
