//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Angela Garrovillas on 4/18/25.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
