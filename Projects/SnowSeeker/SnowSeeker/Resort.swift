//
//  Resort.swift
//  SnowSeeker
//
//  Created by Angela Garrovillas on 5/15/25.
//

import Foundation

struct Resort: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    //Two ways of getting example
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    //static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
}
