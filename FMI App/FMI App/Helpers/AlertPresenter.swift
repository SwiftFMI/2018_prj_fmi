//
//  AlertPresenter.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
import UIKit

public class CustomAlertAction {
    public var title: String
    public var action: (target: NSObjectProtocol?, actionSelector: Selector)?

    public init(title: String, action: (target: NSObjectProtocol?, actionSelector: Selector)? = nil) {
        self.title = title
        self.action = action
    }
}

class AlertPresenter {

    private struct Alert {
        static let errorMessageSeparator = "\n"
    }

    static func showInformationAlert(from viewController: UIViewController,
                                     title: String,
                                     message: String,
                                     okHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "general_ok_button".localized, style: .default, handler: { (action) in
            okHandler?()
        }))
        viewController.present(alertController, animated: true, completion: nil)
    }

    static func showAlert(from viewController: UIViewController,
                          with error: String,
                          okHandler: (() -> Void)? = nil) {
        let title = "general_alert_heading".localized

        AlertPresenter.showInformationAlert(from: viewController, title: title, message: error)
    }
}
