//
//  ContentView.swift
//  FriendFace
//
//  Created by Angela Garrovillas on 4/18/25.
//

import SwiftData
import SwiftUI

struct ActiveView: View {
    var isActive: Bool
    var body: some View {
        if isActive {
            Color.green
                .clipShape(.circle)
                .frame(width: 20, height: 20)
        } else {
            Color.red
                .clipShape(.circle)
                .frame(width: 20, height: 20)
        }
    }
}

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var users = [User]()
    @Query(sort: \User.name) var savedUsers: [User]
    
    var body: some View {
        NavigationStack {
            List(savedUsers, id: \.id) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    HStack {
                        Text(user.name)
                        Spacer()
                        ActiveView(isActive: user.isActive)
                    }
                }
            }
        }
        .task {
            await loadData()
        }
    }
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Failed to get URL")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
                try? modelContext.delete(model: User.self)
                for user in decodedResponse {
                    modelContext.insert(user)
                }
            }
        } catch {
            print("Failed to decode: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
