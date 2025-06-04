//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Angela Garrovillas on 5/15/25.
//

import SwiftUI

@Observable
class Favorites {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let key = "Favorites"

    init() {
        // load our saved data
        if let savedResorts = UserDefaults.standard.data(forKey: key) {
            if let decodedResorts = try? JSONDecoder().decode(Set<String>.self, from: savedResorts) {
                resorts = decodedResorts
            }
        }
        // still here? Use an empty array
        resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set and saves the change
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set and saves the change
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // write out our data
        if let encodedResorts = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encodedResorts, forKey: key)
        }
    }
}
