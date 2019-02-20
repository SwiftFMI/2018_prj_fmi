//
//  LecturesViewController.swift
//  FMI App
//
//  Created by Yalishanda on 4.01.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit

class LecturesViewController: UITableViewController {
    //MARK: Properties
    var selectedSectionId: Int? = nil
    var selectedCourseId: Int? = nil

    var lectures : InformationModels.Lectures?
    var images = [UIImage?]()

    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let courseId = selectedCourseId, let sectionId = selectedSectionId else {
            oops()
            return
        }
        
        //tableView.register(LectureCell.self, forCellReuseIdentifier: "lectureCell")

        Networking.getLectures(section: sectionId, course: courseId) {
            [weak self] (result) in
            guard let result = result else {
                self?.fetchDataFail()
                return
            }
            self?.lectures = result
            for _ in 1...result.lectures.count {
                self?.images.append(nil)
            }
            self?.tableView.reloadData()
        }
    }


    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lectures?.lectures.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "lectureCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LectureCell else {
            return UITableViewCell()
        }

        let lecture = lectures?.lectures[indexPath.row]
        cell.nameLabel.text = lecture?.name
        cell.summaryLabel.text = lecture?.summary

        if let image = images[indexPath.row] {
            cell.photoImageView.image = image
        } else {
            if let imgURL = lecture?.image {
                Networking.getImageFromURL(imgURL) { [weak self] (fetchedImage) in
                    cell.photoImageView.image = fetchedImage
                    self?.images[indexPath.row] = fetchedImage
                    self?.tableView.reloadData()
                }
            }
        }

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SingleLectureViewController, let index = tableView.indexPathForSelectedRow?.row {
            destinationViewController.selectedSectionId = selectedSectionId
            destinationViewController.selectedCourseId = selectedCourseId
            destinationViewController.selectedLectureId = lectures?.lectures[index].id
        }
    }
}
