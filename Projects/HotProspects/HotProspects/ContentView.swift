//
//  ContentView.swift
//  HotProspects
//
//  Created by Angela Garrovillas on 5/2/25.
//

import SamplePackage
import SwiftUI
import UserNotifications

struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    //@State private var selection: String?
    @State private var selection = Set<String>()
    
    @State private var selectedTab = "One"
    
    @State private var output = ""
    
    @State private var backgroundColor = Color.red
    
    let possibleNumbers = 1...60
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    @State private var sortOrder = [SortDescriptor(\Prospect.name)]
    @State private var sortBy = "Name"
    var body: some View {
        Button("Sort by \(sortBy)") {
            if sortBy == "Name" {
                sortBy = "Date"
                sortOrder = [SortDescriptor(\Prospect.date)]
            } else {
                sortBy = "Name"
                sortOrder = [SortDescriptor(\Prospect.name)]
            }
        }
        TabView {
            ProspectsView(filter: .none, sortOrder: sortOrder)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted, sortOrder: sortOrder)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted, sortOrder: sortOrder)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        
        //MARK: swift package dependencies
        //Text(results)
        
        //MARK: Local notifications
//        VStack {
//            Button("Request Permission") {
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("All set!")
//                    } else if let error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//
//            Button("Schedule Notification") {
//                let content = UNMutableNotificationContent()
//                content.title = "Feed the cat"
//                content.subtitle = "It looks hungry"
//                content.sound = UNNotificationSound.default
//
//                // show this notification five seconds from now
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//                // choose a random identifier
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                // add our notification request
//                UNUserNotificationCenter.current().add(request)
//            }
//        }
        
        //MARK: Custom swipe actions
//        List {
//            Text("Taylor Swift")
//                .swipeActions {
//                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
//                        print("Deleting")
//                    }
//                }
//                .swipeActions(edge: .leading) {
//                    Button("Pin", systemImage: "pin") {
//                        print("Pinning")
//                    }
//                    .tint(.orange)
//                }
//        }
        
//        List {
//            Text("Taylor Swift")
//                .swipeActions {
//                    Button("Send message", systemImage: "message") {
//                        print("Hi")
//                    }
//                }
//        }
        
        //MARK: Context menus
//        VStack {
//                    Text("Hello, World!")
//                        .padding()
//                        .background(backgroundColor)
//
//                    Text("Change Color")
//                        .padding()
//                        .contextMenu {
//                            Button("Red") {
//                                backgroundColor = .red
//                            }
//                            Button("Red", systemImage: "checkmark.circle.fill") {
//                                backgroundColor = .red
//                            }
//                            Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
//                                backgroundColor = .red
//                            }
//
//                            Button("Green") {
//                                backgroundColor = .green
//                            }
//
//                            Button("Blue") {
//                                backgroundColor = .blue
//                            }
//                        }
//                }
        
        //MARK: Image interpolation
//        Image(.example)
//            .interpolation(.none)
//            .resizable()
//            .scaledToFit()
//            .background(.black)
        
        //MARK: Swift's Result type
//        Text(output)
//                    .task {
//                        await fetchReadings()
//                    }
        
        //MARK: Creating tabs with TabView and tabItem()
//        TabView(selection: $selectedTab) {
//            Button("Show Tab 2") {
//                selectedTab = "Two"
//            }
//            .tabItem {
//                Label("One", systemImage: "star")
//            }
//            .tag("One")
//            
//            Text("Tab 2")
//                .tabItem {
//                            Label("Two", systemImage: "circle")
//                        }
//                .tag("Two")
//        }
        
        //MARK: Letting users select an item in a list
//        List(users, id: \.self, selection: $selection) { user in
//                    Text(user)
//                }
//        if let selection {
//            Text("You selected \(selection)")
//        }
//        if selection.isEmpty == false {
//            Text("You selected \(selection.formatted())")
//        }
//        EditButton()
    }
//    func fetchReadings() async {
//            do {
//                let url = URL(string: "https://hws.dev/readings.json")!
//                let (data, _) = try await URLSession.shared.data(from: url)
//                let readings = try JSONDecoder().decode([Double].self, from: data)
//                output = "Found \(readings.count) readings"
//            } catch {
//                print("Download error")
//            }
//        }
    func fetchReadings() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        let result = await fetchTask.result
        switch result {
            case .success(let str):
                output = str
            case .failure(let error):
                output = "Error: \(error.localizedDescription)"
        }
        //same as:
//        do {
//            output = try result.get()
//        } catch {
//            output = "Error: \(error.localizedDescription)"
//        }
    }
}

#Preview {
    ContentView()
}
