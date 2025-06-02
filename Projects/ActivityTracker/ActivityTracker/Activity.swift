//
//  Activity.swift
//  ActivityTracker
//
//  Created by Angela Garrovillas on 4/10/25.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var unit: String
    private var count: Int = 0
    
    func activityAmount() -> Int {
        return count
    }
    
    mutating func activityCompleted() {
        count += 1
    }
    
    init(title: String, description: String, unit: String) {
        self.title = title
        self.description = description
        self.unit = unit
    }
}
