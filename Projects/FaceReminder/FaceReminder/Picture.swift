//
//  Picture.swift
//  FaceReminder
//
//  Created by Angela Garrovillas on 5/1/25.
//

import CoreLocation
import Foundation

struct Picture: Codable, Comparable {
    var name: String
    var data: Data
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        get {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    static func < (lhs: Picture, rhs: Picture) -> Bool {
        lhs.name < rhs.name
    }
    
    init(name: String, data: Data, latitude: Double, longitude: Double) {
        self.name = name
        self.data = data
        self.latitude = latitude
        self.longitude = longitude
    }
}
