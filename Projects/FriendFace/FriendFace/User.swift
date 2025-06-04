//
//  User.swift
//  FriendFace
//
//  Created by Angela Garrovillas on 4/18/25.
//

import SwiftData
import SwiftUI

@Model
class User: Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    @Relationship(deleteRule: .cascade) var friends: [Friend]
    
    var formattedDate: String {
        return registered.formatted(date: .abbreviated, time: .omitted)
    }
    
    init(id: UUID, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, tags: [String], friends: [Friend]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _isActive = "isActive"
        case _name = "name"
        case _age = "age"
        case _company = "company"
        case _email = "email"
        case _address = "address"
        case _about = "about"
        case _registered = "registered"
        case _tags = "tags"
        case _friends = "friends"
    }
    
    required init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(UUID.self, forKey: ._id) ?? UUID()
        self.isActive = try values.decodeIfPresent(Bool.self, forKey: ._isActive) ?? false
        self.name = try values.decodeIfPresent(String.self, forKey: ._name) ?? ""
        self.age = try values.decodeIfPresent(Int.self, forKey: ._age) ?? 0
        self.company = try values.decodeIfPresent(String.self, forKey: ._company) ?? ""
        self.email = try values.decodeIfPresent(String.self, forKey: ._email) ?? ""
        self.address = try values.decodeIfPresent(String.self, forKey: ._address) ?? ""
        self.about = try values.decodeIfPresent(String.self, forKey: ._about) ?? ""
        self.registered = try values.decodeIfPresent(Date.self, forKey: ._registered) ?? Date.now
        self.tags = try values.decodeIfPresent([String].self, forKey: ._tags) ?? []
        self.friends = try values.decodeIfPresent([Friend].self, forKey: ._friends) ?? []
    }
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(isActive, forKey: ._isActive)
        try container.encode(name, forKey: ._name)
        try container.encode(age, forKey: ._age)
        try container.encode(company, forKey: ._company)
        try container.encode(email, forKey: ._email)
        try container.encode(address, forKey: ._address)
        try container.encode(about, forKey: ._about)
        try container.encode(registered, forKey: ._registered)
        try container.encode(tags, forKey: ._tags)
        try container.encode(friends, forKey: ._friends)
    }
}

@Model
class Friend: Codable {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _name = "name"
    }
    
    required init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(UUID.self, forKey: ._id) ?? UUID()
        self.name = try values.decodeIfPresent(String.self, forKey: ._name) ?? ""
    }
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(name, forKey: ._name)
    }
}
