//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Angela Garrovillas on 5/14/25.
//

import SwiftUI

struct User: Identifiable {
    var id = "Ash Ketchum"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

@Observable
class Player {
    var name = "Anonymous"
    var highScore = 0
}

struct HighScoreView: View {
    var player: Player

    var body: some View {
        Text("Your high score: \(player.highScore)")
    }
}

struct ContentView: View {
//    @State private var selectedUser: User? = nil
//    @State private var isShowingUser = false
//    @State private var layoutVertically = false
//    @State private var searchText = ""
    //@State private var player = Player()
    
//    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    
//    var filteredNames: [String] {
//            if searchText.isEmpty {
//                allNames
//            } else {
//                allNames.filter { $0.localizedStandardContains(searchText) }
//            }
//        }
    
//    @Environment(\.horizontalSizeClass) var horizontalSizeClass
//    @Environment(Player.self) var player
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
           resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var sortedResorts: [Resort] {
        switch selectedSort {
        case "alphabetical":
            return filteredResorts.sorted {
                $0.name < $1.name
            }
        case "country":
            return filteredResorts.sorted {
                $0.country < $1.country
            }
        default:
            return filteredResorts
        }
    }
    
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var selectedSort = "default"
    
    var body: some View {
        NavigationSplitView {
            List(sortedResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .toolbar {
                Menu("Sort", systemImage: "gear") {
                    Picker("Sort", selection: $selectedSort) {
                        Text("Default")
                            .tag("default")
                        Text("Alphabetical")
                            .tag("alphabetical")
                        Text("Country")
                            .tag("country")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
        } detail: {
            WelcomeView()
        }
        
        
        .environment(favorites)
        
        //MARK: Sharing @Observable objects through SwiftUI's environment
//        @Bindable var player = player
//        Stepper("High score: \(player.highScore)", value: $player.highScore)
//        VStack {
//            Text("Welcome!")
//            HighScoreView(player: player)
//        }
//        .environment(player)
        
//        VStack {
//                    Text("Welcome!")
//                    HighScoreView(player: player)
//                }
        
        //MARK: Making a SwiftUI view searchable
//        NavigationStack {
//                    List(filteredNames, id: \.self) { name in
//                        Text(name)
//                    }
//                    .searchable(text: $searchText, prompt: "Look for something")
//                    .navigationTitle("Searching")
//                }
        
//        NavigationStack {
//                    Text("Searching for \(searchText)")
//                        .searchable(text: $searchText, prompt: "Look for something")
//                        .navigationTitle("Searching")
//                }
        
        //MARK: Using groups as transparent layout containers
//        ViewThatFits {
//            Rectangle()
//                .frame(width: 500, height: 200)
//
//            Circle()
//                .frame(width: 200, height: 200)
//        }
        
//        if horizontalSizeClass == .compact {
//            VStack(content: UserView.init)
//        } else {
//            HStack(content: UserView.init)
//        }
//        if horizontalSizeClass == .compact {
//                    VStack {
//                        UserView()
//                    }
//                } else {
//                    HStack {
//                        UserView()
//                    }
//                }
        
//        Button {
//                    layoutVertically.toggle()
//                } label: {
//                    if layoutVertically {
//                        VStack {
//                            UserView()
//                        }
//                    } else {
//                        HStack {
//                            UserView()
//                        }
//                    }
//                }
        
        //MARK: Using alert() and sheet() with optionals
//        Button("Tap Me") {
//            selectedUser = User()
//            isShowingUser = true
//        }
//        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//            Button(user.id) { }
//        }
//        .sheet(item: $selectedUser) { user in
//            Text(user.id)
//                .presentationDetents([.medium, .large])
//        }
        
        //MARK: Working with two side by side views in SwiftUI
        //keep the primary view around when space is partially limited
//        NavigationSplitView(columnVisibility: .constant(.all)) {
        //can tell the system to prefer the detail view by default, which is helpful on iPhone where the primary view is selected as standard
//        NavigationSplitView(preferredCompactColumn: .constant(.detail)) {
//            NavigationLink("Primary") {
//                Text("New view")
//            }
//        } detail: {
//            Text("Content")
//                .navigationTitle("Content View")
//        }
//        .navigationSplitViewStyle(.balanced)
        
//        NavigationSplitView {
//            NavigationLink("Primary") {
//                Text("New view")
//            }
//        } detail: {
//            Text("Content")
//        }
        
//        NavigationView {
//                    Text("Hello, world!")
//                        .navigationTitle("Primary")
//                }
    }
}

#Preview {
    ContentView()
}
