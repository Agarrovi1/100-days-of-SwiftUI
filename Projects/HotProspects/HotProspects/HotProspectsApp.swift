//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Angela Garrovillas on 5/2/25.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
