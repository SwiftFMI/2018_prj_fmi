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

                guard let data = data, err == nil else {
                    completion(nil)
                    return
                }
                
                completion(UIImage(data: data))
            }
        }.resume()
    }
    
    static func getSections(completion: @escaping (InformationModels.Sections?) -> ()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let url = URL(string: "https://fmi-app.firebaseio.com/sections.json")!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                //print(error)
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let sections = try JSONDecoder().decode(InformationModels.Sections.self, from: data)
                    completion(sections)
                } catch {
                    completion(nil)
                }
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
        }.resume()
        
    }
}
