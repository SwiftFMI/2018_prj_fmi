//
//  SingleLectureViewController.swift
//  FMI App
//
//  Created by Yalishanda on 4.01.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import UIKit
import MarkdownView
import SafariServices

class SingleLectureViewController: UIViewController {
    // MARK: Properties
    var selectedSectionId: Int? = nil
    var selectedCourseId: Int? = nil
    var selectedLectureId: Int? = nil
    var lecture: InformationModels.Lecture? = nil
    var lecturerImage: UIImage? = nil
    let mdView = MarkdownView()
    
    // MARK: Outlets
    
    @IBOutlet weak var lectureNameLabel: UILabel!
    @IBOutlet weak var lectureSubtitleLabel: UILabel!
    @IBOutlet weak var lecturerImageView: UIImageView!
    @IBOutlet weak var lecturerNameLabel: UILabel!
    @IBOutlet weak var lecturerSubtitleLabel: UILabel!
 
    @IBOutlet weak var detailsView: UIView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let courseId = selectedCourseId, let sectionId = selectedSectionId, let lectureId = selectedLectureId else {
            oops()
            return
        }
        
        
        detailsView.addSubview(mdView)
        mdView.translatesAutoresizingMaskIntoConstraints = false
        mdView.topAnchor.constraint(equalTo: detailsView.topAnchor).isActive = true
        mdView.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor).isActive = true
        mdView.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor).isActive = true
        mdView.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor).isActive = true
        
        mdView.onTouchLink = { [weak self] request in
            guard let url = request.url else { return false }
            
            if url.scheme == "https" || url.scheme == "http" {
                let safari = SFSafariViewController(url: url)
                self?.navigationController?.pushViewController(safari, animated: true)
                return false
            } else {
                return false
            }
        }
        
        Networking.getLecture(section: sectionId, course: courseId, lecture: lectureId) { [weak self](result) in
            guard let result = result else {
                self?.fetchDataFail()
                return
            }
            self?.lecture = result
            
            
                if let imgURL = self?.lecture?.lecturer.photo {
                    Networking.getImageFromURL(imgURL, completion: { [weak self] (img) in
                        self?.lecturerImage = img
                        DispatchQueue.main.async {
                            self?.updateViews()
                        }
                    })
                }
            
            DispatchQueue.main.async {
                self?.updateViews()
            }
            
            
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //updateViews()
    }
    
    
    // MARK: Methods
    func updateViews() {
        lectureNameLabel.text = lecture?.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yyyy"
        var subtitleText = ""
        
        if let date = lecture?.date {
            subtitleText = dateFormatter.string(from: date)
            
            if let updated = lecture?.updated {
                subtitleText = "\(subtitleText) (Последна редакция: \(dateFormatter.string(from: updated)))"
            }
        }
        
        
        lectureSubtitleLabel.text = subtitleText
        
        lecturerImageView.image = lecturerImage
        lecturerNameLabel.text = lecture?.lecturer.name
        lecturerSubtitleLabel.text = lecture?.lecturer.position
        
        mdView.load(markdown: lecture?.details)
    }
}
