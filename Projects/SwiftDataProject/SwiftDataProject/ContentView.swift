//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Angela Garrovillas on 4/17/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    //@Query(sort: \User.name) var users: [User]
//    @Query(filter: #Predicate<User> { user in
//        user.name.localizedStandardContains("R") &&
//        user.city == "Pewter"
//        if user.name.localizedStandardContains("R") {
//            if user.city == "Pewter" {
//                return true
//            } else {
//                return false
//            }
//        } else {
//            return false
//        }
//    }, sort: \User.name) var users: [User]
    @State private var showUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    @State private var path = [User]()
    var body: some View {
        NavigationStack(path: $path) {
//            List(users) { user in
//                NavigationLink(value: user) {
//                    Text(user.name)
//                }
//            }
            UsersView(minimumJoinDate: showUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
//                Button("Add user", systemImage: "plus") {
//                    let user = User(name: "", city: "", joinDate: .now)
//                    modelContext.insert(user)
//                    path = [user]
//                }
                Button("Add Sample Users", systemImage: "plus") {
                    let first = User(name: "Ash", city: "Pallet", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Brock", city: "Pewter", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Misty", city: "Cerulean", joinDate: .now.addingTimeInterval(86400 * 5))
                    let forth = User(name: "Gary", city: "Pallet", joinDate: .now.addingTimeInterval(86400 * 10))
                    
                    //delete existing data before adding the samples
                    try? modelContext.delete(model: User.self)
                    
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(forth)
                }
                Button(showUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                    showUpcomingOnly.toggle()
                }
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate)
                            ])
                        Text("Sort by Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
