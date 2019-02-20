//
//  Networking.swift
//  FMI App
//
//  Created by Yalishanda on 20.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
import UIKit

final class Networking {
    static let shared = Networking()
    private init() {}
    
    static func getImageFromURL(_ url: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        URLSession.shared.dataTask(with: url) {
            (data, _, err) in
     
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }

            guard let data = data, err == nil else {
                completion(nil)
                return
            }
                
            completion(UIImage(data: data))
            
        }.resume()
    }
    
    
    private static func getJSONData(from url: URL, completion: @escaping (Data?) -> ()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                completion(data)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }.resume()
    }
    
    
    static func getSections(completion: @escaping (InformationModels.Sections?) -> ()) {
        let url = URL(string: "https://fmi-app.firebaseio.com/sections.json")!
        
        Networking.getJSONData(from: url) { (data) in
            if let data = data {
                let sections = try? JSONDecoder().decode(InformationModels.Sections.self, from: data)
                completion(sections)
            } else {
                completion(nil)
            }
        }
        
    }
    
    static func getCourses(section id: Int, completion: @escaping (InformationModels.Courses?) -> ()) {
        let url = URL(string: "https://fmi-app.firebaseio.com/sections/\(id).json")!
        
        Networking.getJSONData(from: url) { (data) in
            if let data = data {
                let courses = try? JSONDecoder().decode(InformationModels.Courses.self, from: data)
                completion(courses)
            } else {
                completion(nil)
            }
        }
        
    }
    
}
