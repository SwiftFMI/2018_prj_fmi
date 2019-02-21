//
//  Alerts.swift
//  FMI App
//
//  Created by Yalishanda on 20.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    private func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func fetchDataFail() {
        makeAlert(title: "Няма информация", message: "Възможно е да няма връзка с интернет.")
    }
    
    func oops() {
        makeAlert(title: "Опа", message: "За съжаление, нещо се обърка :(")
    }
}
