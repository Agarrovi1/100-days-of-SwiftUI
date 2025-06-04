//
//  ContentView.swift
//  Moonshot
//
//  Created by Angela Garrovillas on 4/4/25.
//

import SwiftUI

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView: View {
//    let layout =  [
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80))
//        GridItem(.adaptive(minimum: 80, maximum: 120))
//    ]
    @State private var isShowingGrid = true
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    let rows = [GridItem(.adaptive(minimum: .infinity))]
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: isShowingGrid ? columns : rows) {
                    ForEach(missions) { mission in
                        NavigationLink(value: mission) {
                            GridView(mission: mission)
                        }
//                        NavigationLink {
//                            MissionView(mission: mission, astronauts: astronauts)
//                        } label: {
//                            VStack {
//                                Image(mission.image)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 100, height: 100)
//                                    .padding()
//                                VStack {
//                                    Text(mission.displayName)
//                                        .font(.headline)
//                                        .foregroundStyle(.white)
//                                    Text(mission.formattedLaunchDate)
//                                        .font(.caption)
//                                        .foregroundStyle(.white.opacity(0.5))
//                                }
//                                .padding(.vertical)
//                                .frame(maxWidth: .infinity)
//                                .background(.lightBackground)
//                            }
//                            .clipShape(.rect(cornerRadius: 10))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(.lightBackground)
//                            )
//                        }
                    }
                    
                }
                .padding([.horizontal, .bottom])
                .navigationDestination(for: Mission.self) { selection in
                    MissionView(mission: selection, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(isShowingGrid ? "List" : "Grid") {
                    isShowingGrid.toggle()
                }
            }
        }
        
        //MARK: lay out views in a scrolling grid
//        Section("Horizontal Grid") {
//            ScrollView(.horizontal) {
//                LazyHGrid(rows: layout) {
//                    ForEach(0..<1000) {
//                        Text("Item \($0)")
//                    }
//                }
//            }
//        }
//        Section("Vertical Grid") {
//            ScrollView {
//                LazyVGrid(columns: layout) {
//                    ForEach(0..<1000) {
//                        Text("Item \($0)")
//                    }
//                }
//            }
//        }
        
        //MARK: decoding more hierachical data with Codable
//        Button("Decode JSON") {
//            let input = """
//            {
//                "name": "Fugue",
//                "address": {
//                    "street": "Artist Alley",
//                    "city": "Luofu"
//                }
//            }
//            """
//
//            let data = Data(input.utf8)
//            let decoder = JSONDecoder()
//            if let user = try? decoder.decode(User.self, from: data) {
//                print(user.address.street)
//            }
//        }
        
        //MARK: NavigationLink
//        NavigationStack {
//            List(0..<100) { row in
//                NavigationLink("Row \(row)") {
//                    Text("Detail \(row)")
//                }
//            }
//            NavigationLink {
//                Text("Detail View")
//            } label: {
//                VStack {
//                    Text("This is the label")
//                    Text("So is this")
//                    Image(systemName: "face.smiling")
//                }
//                .font(.largeTitle)
//            }
//                .navigationTitle("SwiftUI")
//        }
        
        //MARK: ScrollViews
//        ScrollView(.horizontal) {
//            LazyHStack(spacing: 10) {
//                ForEach(0..<100) {
//                    CustomText("Item \($0)")
//                        .font(.title)
//                }
//            }
//            //to make whole area scrollable
//            .frame(maxWidth: .infinity)
//        }
        
        //MARK: Resizing Images
//        Image(.fugue)
//            .resizable()
//            .scaledToFit()
//            .containerRelativeFrame(.horizontal) { size, axis in
//                size * 0.8
//            }
    }
}

#Preview {
    ContentView()
}
