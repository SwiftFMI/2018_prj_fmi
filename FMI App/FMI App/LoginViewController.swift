//
//  LoginViewController.swift
//  FMI App
//
//  Created by Yalishanda on 3.01.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet var roundedViewsCollection: [UIView]!
    
    let viewsCornerRadius : CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in roundedViewsCollection {
            view.layer.cornerRadius = viewsCornerRadius
        }
    }
    
    @IBAction func didTapToEndInput(_ sender: Any) {
        view.endEditing(true)
    }
}
