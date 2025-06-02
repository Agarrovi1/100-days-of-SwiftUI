//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Angela Garrovillas on 4/10/25.
//

import SwiftUI

@Observable
class Activities {
    var items = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    
    @State private var activities = Activities()
    var body: some View {
        NavigationStack {
            List(activities.items) { activity in
                NavigationLink {
                    DetailView(activity: activity, activities: activities)
                } label: {
                    Text(activity.title)
                }
            }
            .navigationTitle("Activities")
            .toolbar {
                NavigationLink {
                    AddView(activities: activities)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
