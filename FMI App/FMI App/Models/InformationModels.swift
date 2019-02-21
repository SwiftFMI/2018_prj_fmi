//
//  InformationModel.swift
//  FMI App
//
//  Created by Yalishanda on 20.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation

class InformationModels {
    public static let shared = InformationModels()
    private init() {}
    
    struct Sections: Decodable {
        enum SectionCodingKeys: String, CodingKey {
            case id; case name; case image
        }
        
        var sections = [(id: Int?, name: String?, image: String?)]()
        
        init(from decoder: Decoder) throws {
            var sectionsNestedContainer = try decoder.unkeyedContainer()
            
            if let numberOfSections = sectionsNestedContainer.count {
                for _ in 1...numberOfSections {
                    let sectionsValueContainer = try sectionsNestedContainer.nestedContainer(keyedBy: SectionCodingKeys.self)
                    let currId = try? sectionsValueContainer.decode(Int.self, forKey: .id)
                    let currName = try? sectionsValueContainer.decode(String.self, forKey: .name)
                    let currImage = try? sectionsValueContainer.decode(String.self, forKey: .image)
                    
                    sections.append((currId, currName, currImage))
                }
                
            }
        }
    }
    
    
    struct Courses : Decodable {
        enum TopLevelCodingKey: String, CodingKey {
            case courses
        }
        enum CourseCodingKeys: String, CodingKey {
            case id; case name; case image
        }
        
        var courses = [(id: Int?, name: String?, image: String?)]()
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: TopLevelCodingKey.self)
            var coursesUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .courses)
            
            if let numberOfSections = coursesUnkeyedContainer.count {
                for _ in 1...numberOfSections {
                    let coursesValueContainer = try coursesUnkeyedContainer.nestedContainer(keyedBy: CourseCodingKeys.self)
                    let currId = try? coursesValueContainer.decode(Int.self, forKey: .id)
                    let currName = try? coursesValueContainer.decode(String.self, forKey: .name)
                    let currImage = try? coursesValueContainer.decode(String.self, forKey: .image)
                    
                    courses.append((currId, currName, currImage))
                }
                
            }
        }
    }
    
    
    struct Lectures : Decodable {
        enum TopLevelCodingKey: String, CodingKey {
            case lectures
        }
        enum LectureCodingKeys: String, CodingKey {
            case id; case name; case summary; case image; case date
        }
        
        var lectures = [(id: Int?, name: String?, image: String?, summary: String?, date: Date?)]()
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: TopLevelCodingKey.self)
            var lecturesUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .lectures)
            
            if let numberOfSections = lecturesUnkeyedContainer.count {
                for _ in 1...numberOfSections {
                    let lecturesValueContainer = try lecturesUnkeyedContainer.nestedContainer(keyedBy: LectureCodingKeys.self)
                    let currId = try? lecturesValueContainer.decode(Int.self, forKey: .id)
                    let currName = try? lecturesValueContainer.decode(String.self, forKey: .name)
                    let currImage = try? lecturesValueContainer.decode(String.self, forKey: .image)
                    let currSummary = try? lecturesValueContainer.decode(String.self, forKey: .summary)
                    let dateString = try? lecturesValueContainer.decode(String.self, forKey: .date)
                    
                    var currDate: Date? = nil
                    if let date = dateString {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyymmdd"
                        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")
                        currDate = dateFormatter.date(from: date)
                    }
                    
                    lectures.append((currId, currName, currImage, currSummary, currDate))
                }
                
            }
        }
    }
    
    
    struct Lecture : Decodable {
        enum LectureCodingKeys: String, CodingKey {
            case date
            case id
            case name
            case summary
            case lecturer
            case updated
            case details
        }
        
        enum LecturerCodingKeys: String, CodingKey {
            case name
            case position
            case photo
        }
        
        
        var date: Date?, id: Int?, name: String?, summary: String?, updated: Date?, details: String?
        var lecturer: (name: String?, position: String?, photo: String?)
        
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: LectureCodingKeys.self)
            
            let dateString = try? container.decode(String.self, forKey: .date)
            id = try? container.decode(Int.self, forKey: .id)
            name = try? container.decode(String.self, forKey: .name)
            summary = try? container.decode(String.self, forKey: .summary)
            let updatedString = try? container.decode(String.self, forKey: .updated)
            details = try? container.decode(String.self, forKey: .details)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyymmdd"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")
            
            if let dateString = dateString {
                date = dateFormatter.date(from: dateString)
            }
            if let updatedString = updatedString {
                updated = dateFormatter.date(from: updatedString)

            }
            
            let lecturerNestedContainer = try container.nestedContainer(keyedBy: LecturerCodingKeys.self, forKey: .lecturer)
            
            lecturer.name = try? lecturerNestedContainer.decode(String.self, forKey: .name)
            lecturer.position = try? lecturerNestedContainer.decode(String.self, forKey: .position)
            lecturer.photo = try? lecturerNestedContainer.decode(String.self, forKey: .photo)
        }
    }
}
