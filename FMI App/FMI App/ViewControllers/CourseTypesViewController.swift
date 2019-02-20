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
    var sections : InformationModels.Sections?
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        Networking.getSections() {
            [weak self] (sectionsResult) in
            guard let result = sectionsResult else {
                self?.fetchDataFail()
                return
            }
            self?.sections = result
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 	sections?.sections.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CoursesTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CoursesTypeViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        // Fetches the appropriate course for the data source layout.
        let course = sections?.sections[indexPath.row]
        
        cell.nameLabel.text = course?.name
        if let imgName = course?.image {
            cell.photoImageView.image = UIImage(named: imgName)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? LoginViewController, let index = tableView.indexPathForSelectedRow?.row {
            destinationViewController.selectedSectionId = sections?.sections[index].id
        }
    }
}

