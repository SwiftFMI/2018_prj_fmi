//
//  SingleLectureViewController.swift
//  FMI App
//
//  Created by Yalishanda on 4.01.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit

class SingleLectureViewController: UITableViewController {
    // MARK: Properties
    var selectedSectionId: Int? = nil
    var selectedCourseId: Int? = nil
    var selectedLectureId: Int? = nil
    var lecture: InformationModels.Lecture? = nil
    var lecturerImage: UIImage? = nil
    
    // MARK: Outlets
    
    @IBOutlet weak var lectureNameLabel: UILabel!
    @IBOutlet weak var lectureSubtitleLabel: UILabel!
    @IBOutlet weak var lecturerImageView: UIImageView!
    @IBOutlet weak var lecturerNameLabel: UILabel!
    @IBOutlet weak var lecturerSubtitleLabel: UILabel!
    @IBOutlet weak var lectureText: UITextView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let courseId = selectedCourseId, let sectionId = selectedSectionId, let lectureId = selectedLectureId else {
            oops()
            return
        }
        
        Networking.getLecture(section: sectionId, course: courseId, lecture: lectureId) { [weak self](result) in
            guard let result = result else {
                self?.fetchDataFail()
                return
            }
            self?.lecture = result
            self?.updateViews()
        }
        
        if let imgURL = lecture?.lecturer.photo {
            Networking.getImageFromURL(imgURL, completion: { [weak self] (img) in
                self?.lecturerImage = img
                self?.updateViews()
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateViews()
    }
    
    
    // MARK: Methods
    func updateViews() {
        lectureNameLabel.text = lecture?.name
        lectureSubtitleLabel.text = lecture?.summary
        
        lecturerImageView.image = lecturerImage
        lecturerNameLabel.text = lecture?.lecturer.name
        lecturerSubtitleLabel.text = lecture?.lecturer.position
        
        lectureText.text = lecture?.details ?? ""
    }
}
