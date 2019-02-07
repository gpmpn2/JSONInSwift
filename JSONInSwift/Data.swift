//
//  Photos.swift
//  JSONInSwift
//
//  Created by Grant Maloney on 2/7/19.
//  Copyright © 2019 Grant Maloney. All rights reserved.
//

import Foundation

let url = "https://dalemusser.com/code/examples/data/nocaltrip/photos.json"

struct Trip: Codable {
    let status, photosPath: String
    let photos: [Photo]
}

struct Photo: Codable {
    let image, title, description: String
    let latitude, longitude: Double
    let date: String
}

extension MainViewController {
    func handleCodableData(completion: @escaping(Trip?) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let urlData = try decoder.decode(Trip.self, from: data)
                completion(urlData)
            } catch let err {
                print("Err", err)
            }
            }.resume()
        return
    }
    
    func handleSerializationData(completion: @escaping(Trip?) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                let status = json?.value(forKey: "status") as! String
                let photosPath = json?.value(forKey: "photosPath") as! String
                let photosJson = json?.value(forKey: "photos") as! NSArray
                var photos: [Photo] = []
                
                for photo in photosJson {
                    if let photo = photo as? NSDictionary {
                        photos.append(Photo(image: photo.value(forKey: "image") as! String, title: photo.value(forKey: "title") as! String, description: photo.value(forKey: "description") as! String, latitude: photo.value(forKey: "latitude") as! Double, longitude: photo.value(forKey: "longitude") as! Double, date: photo.value(forKey: "date") as! String))
                    }
                }
                
                completion(Trip(status: status, photosPath: photosPath, photos: photos))
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
}
