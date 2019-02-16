//
//  Sections.swift
//  FMI App
//
//  Created by Alexander on 16.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation

class Sections: Decodable {
    enum TopLevelCodingKey: String, CodingKey {
        case sections
    }
    enum SectionCodingKeys: String, CodingKey {
        case id; case name; case image
    }
    
    var sections = [(id: Int?, name: String?, image: String?)]()
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TopLevelCodingKey.self)
        
        var sectionsNestedContainer = try container.nestedUnkeyedContainer(forKey: .sections)
        
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
