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
                    let currId = try sectionsValueContainer.decode(Int.self, forKey: .id)
                    let currName = try sectionsValueContainer.decode(String.self, forKey: .name)
                    let currImage = try sectionsValueContainer.decode(String.self, forKey: .image)
                    
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
                    let currId = try coursesValueContainer.decode(Int.self, forKey: .id)
                    let currName = try coursesValueContainer.decode(String.self, forKey: .name)
                    let currImage = try coursesValueContainer.decode(String.self, forKey: .image)
                    
                    courses.append((currId, currName, currImage))
                }
                
            }
        }
    }
}
