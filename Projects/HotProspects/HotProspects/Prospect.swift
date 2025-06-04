//
//  Prospect.swift
//  HotProspects
//
//  Created by Angela Garrovillas on 5/5/25.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var date: Date
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        date = Date.now
    }
}
