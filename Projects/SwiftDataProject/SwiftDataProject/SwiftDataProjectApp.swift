//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Angela Garrovillas on 4/17/25.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
