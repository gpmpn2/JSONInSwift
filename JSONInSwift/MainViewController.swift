//
//  ViewController.swift
//  JSONInSwift
//
//  Created by Grant Maloney on 2/7/19.
//  Copyright © 2019 Grant Maloney. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var trip: Trip?

    @IBAction func handleCodable(_ sender: Any) {
        handleCodableData(completion: { trip in
            self.trip = trip
            
            DispatchQueue.main.async {
                self.textView.text = ""
                self.textView.text.append("JSON Codable:\n")
                self.textView.text.append("Status: \(trip?.status ?? "")\nPhoto Path: \(trip?.photosPath ?? "")")
                if let photos = trip?.photos {
                    for photo in photos {
                        self.textView.text.append("\n\tImage: \(photo.image)\n\tTitle: \(photo.title)\n\tDescription: \(photo.description)\n\tLatitude: \(photo.latitude)\n\tLongitude: \(photo.longitude)\n\tDate: \(photo.date)")
                    }
                }
            }
        })
    }
    @IBAction func handleSerialization(_ sender: Any) {
        handleSerializationData(completion: { trip in
            self.trip = trip
            DispatchQueue.main.async {
                self.textView.text = ""
                self.textView.text.append("JSONSerialization:\n")
                self.textView.text.append("Status: \(trip?.status ?? "")\nPhoto Path: \(trip?.photosPath ?? "")")
                if let photos = trip?.photos {
                    for photo in photos {
                        self.textView.text.append("\n\tImage: \(photo.image)\n\tTitle: \(photo.title)\n\tDescription: \(photo.description)\n\tLatitude: \(photo.latitude)\n\tLongitude: \(photo.longitude)\n\tDate: \(photo.date)")
                    }
                }
            }
        })
    }
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.isEditable = false
        // Do any additional setup after loading the view, typically from a nib.
    }


}

