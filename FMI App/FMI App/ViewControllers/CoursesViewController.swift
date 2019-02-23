//
//  CoursesViewController.swift
//  FMI App
//
//  Created by Yalishanda on 4.01.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit

class CoursesViewController: UITableViewController {
    //MARK: Properties
    var selectedSectionId: Int? = nil
    var courses : InformationModels.Courses?
    var images = [UIImage?]()
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let id = selectedSectionId else {
            oops()
            return
        }
        
        Networking.getCourses(section: id) {
            [weak self] (result) in
            guard let result = result else {
                self?.fetchDataFail()
                return
            }
            self?.courses = result
            for _ in 1...result.courses.count {
                self?.images.append(nil)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return     courses?.courses.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "courseCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CourseViewCell  else {
            return UITableViewCell()
        }
        
        let course = courses?.courses[indexPath.row]
        cell.nameLabel.text = course?.name
        
        if let image = images[indexPath.row] {
            cell.photoImageView.image = image
        } else {
            if let imgURL = course?.image {
                Networking.getImageFromURL(imgURL) { [weak self] (fetchedImage) in
                    DispatchQueue.main.async {
                        cell.photoImageView.image = fetchedImage
                        self?.images[indexPath.row] = fetchedImage
                        self?.tableView.reloadData()
                    }
                }
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? LecturesViewController, let index = tableView.indexPathForSelectedRow?.row {
            destinationViewController.selectedSectionId = selectedSectionId
            destinationViewController.selectedCourseId = courses?.courses[index].id
        }
    }
}
