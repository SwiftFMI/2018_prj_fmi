//
//  CoursesTypeViewCell.swift
//  FMI App
//
//  Created by Nikolay Nachev on 18.01.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit

class CoursesTypeViewCell: UITableViewCell {
	//MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
