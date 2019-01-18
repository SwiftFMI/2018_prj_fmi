//
//  CourseTypesViewController.swift
//  FMI App
//
//  Created by Yalishanda on 4.01.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit

class CourseTypesViewController: UITableViewController {
    //MARK: Properties
    var courese = [Coureses]()
    
    //MARK: Private Methods
    
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "Programming")
        let photo2 = UIImage(named: "Math")
        let photo3 = UIImage(named: "DataScience")
        
        guard let coures1 = Coureses(name: "Programming", photo: photo1, text: "Programmign courses in FMI") else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let coures2 = Coureses(name: "Math", photo: photo2, text: "Math courses in FMI") else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let coures3 = Coureses(name: "Data science", photo: photo3, text: "Data Science courses inf FMI") else {
            fatalError("Unable to instantiate meal2")
        }
        
        courese += [coures1, coures2, coures3]
        
    }
    override func viewDidLoad() {
        //Load  sample data.
        loadSampleMeals()
        
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 	courese.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CoursesTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CoursesTypeViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        // Fetches the appropriate course for the data source layout.
        let course = courese[indexPath.row]
        
        cell.nameLabel.text = course.name
        cell.photoImageView.image = course.photo
        cell.textField.text = course.text
        return cell
    }
}

