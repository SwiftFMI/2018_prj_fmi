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
    var sectionsInstance : Sections!
    //MARK: Private Methods
    
    private func loadSections() -> Bool {
        // json: Any?
        if let pathForJson = Bundle.main.path(forResource: "sections", ofType: "json") {
            do {
                let fileURL = URL(fileURLWithPath: pathForJson)
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                //json = try? JSONSerialization.jsonObject(with: data)
                sectionsInstance = try JSONDecoder().decode(Sections.self, from: data)
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if loadSections() {
            //tableView.reloadData()
        } else {
            let alert = UIAlertController(title:"Alert", message: "Unable to fetch data.", preferredStyle: .alert)
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 	sectionsInstance?.sections.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CoursesTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CoursesTypeViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        // Fetches the appropriate course for the data source layout.
        let course = sectionsInstance.sections[indexPath.row]
        
        cell.nameLabel.text = course.name
        if let imgName = course.image {
            cell.photoImageView.image = UIImage(named: imgName)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? LoginViewController, let index = tableView.indexPathForSelectedRow?.row {
            destinationViewController.selectedSectionId = sectionsInstance.sections[index].id
        }
    }
}

