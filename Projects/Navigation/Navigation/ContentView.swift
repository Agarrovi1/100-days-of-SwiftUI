//
//  ContentView.swift
//  Navigation
//
//  Created by Angela Garrovillas on 4/8/25.
//

import SwiftUI

struct DetailView: View {
    var number: Int
    
    @Binding var path: [Int]
    
    var body: some View {
        //Text("Detail View \(number)")
        NavigationLink("Go to Random Number", value: Int.random(in: 0...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    path.removeAll()
                }
            }
    }
//    init(number: Int) {
//        self.number = number
//        print("Creating detail view \(number)")
//    }
}

struct NavPathDetailView: View {
    var number: Int
    var body: some View {
        NavigationLink("Go to random number", value: Int.random(in: 0...1000))
            .navigationTitle("Number \(number)")
    }
}

struct Student: Hashable {
    var id: UUID
    var name: String
    var age: Int
}

@Observable
class PathStore {
    //var path: [Int] {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            //if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        //path = []
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct ContentView: View {
    //@State private var path = [Int]()
    @State private var path = NavigationPath()
    @State private var numberPath = [Int]()
    @State private var pathStore = PathStore()
    
    @State private var title = "SwiftUI"
    
    var body: some View {
        
        NavigationStack {
            Text("Hello world")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
        
        //MARK: placing toolbar items in exact locations
//        NavigationStack {
//            Text("Hello world")
//                .toolbar {
//                    ToolbarItemGroup(placement: .topBarLeading) {
//                        Button("Tap me") {
//                            
//                        }
//                        Button("Tap me 2") {
//                            
//                        }
//                    }
////                    ToolbarItem(placement: .topBarLeading) {
////                        Button("Tap me") {
////                            
////                        }
////                    }
////                    ToolbarItem(placement: .topBarLeading) {
////                        Button("Second tap me") {
////                            
////                        }
////                    }
//                    ToolbarItem(placement: .confirmationAction) {
//                        Button("Tap me too") {
//                            
//                        }
//                    }
//                }
//        }
        
        //MARK: Customizing Navigation toolbar
//        NavigationStack {
//            List(0..<100) { i in
//                Text("Row \(i)")
//            }
//            .navigationTitle("Title goes here")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(.blue)
//            .toolbarColorScheme(.dark)
//            .toolbar(.hidden, for: .navigationBar)
        //}
        
        //MARK: storing navigationPath with Codable
//        NavigationStack(path: $pathStore.path) {
//            NavPathDetailView(number: 0)
//                .navigationDestination(for: Int.self) { i in
//                    NavPathDetailView(number: i)
//                }
//        }
        
        //MARK: Returning to root view programmatically
//        NavigationStack(path: $numberPath) {
//            DetailView(number: 0, path: $numberPath)
//                .navigationDestination(for: Int.self) { i in
//                    DetailView(number: i, path: $numberPath)
//                }
//        }
        
        //MARK: NavigationPath
//        NavigationStack(path: $path) {
//            List {
//                ForEach(0..<5) { i in
//                    NavigationLink("Select Number: \(i)", value: i)
//                }
//                ForEach(0..<5) { i in
//                    NavigationLink("Select String: \(i)", value: String(i))
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected the number \(selection)")
//            }
//            .navigationDestination(for: String.self) { selection in
//                Text("You selected the string \(selection)")
//            }
//            .toolbar {
//                Button("Push 556") {
//                    path.append(556)
//                }
//                Button("Push Hello") {
//                    path.append("Hello")
//                }
//            }
//        }
        
        //MARK: Programmatic navigation
//        NavigationStack(path: $path) {
//            VStack {
//                // we're setting the whole array so that it just contains the number 32. If anything else happened to be in the array it will be removed, meaning that the NavigationStack will return to its original state before navigating to the number 32.
//                Button("Show 32") {
//                    path = [32]
//                }
//                //we're appending 64, meaning that it will be added to whatever we were navigating to. So, if our array already contained 32, we'd now have three views in the stack: the original view (called the "root" view), then something to show the number 32, and finally something to show the number 64.
//                Button("Show 64") {
//                    path.append(64)
//                }
//                Button("Show 32, then 64") {
//                    path = [32, 64]
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
//        }
        
        //MARK: navigating with navigationDestination
//        NavigationStack {
//            List(0..<1000) { i in
//                NavigationLink("Select \(i)", value: i)
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
//        }
        
        //MARK: creates detail view each time the link is shown, not effective
//        NavigationStack {
//            List(0..<500) { i in
//                NavigationLink("Tap Me") {
//                    DetailView(number: i)
//                }
//            }
//        }
    }
}

#Preview {
    ContentView()
}
