//
//  Courses.swift
//  FMI App
//
//  Created by Nikolay Nachev on 18.01.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit
class Coureses {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var text: String
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, text: String) {
        // Initialization should fail if there is no name or text.
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        
        guard !text.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.text = text
        
    }
}
