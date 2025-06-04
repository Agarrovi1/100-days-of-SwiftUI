//
//  DetailView.swift
//  FriendFace
//
//  Created by Angela Garrovillas on 4/18/25.
//

import SwiftUI

struct DetailView: View {
    var user: User
    var body: some View {
        VStack {
            HStack {
                Text(user.name)
                    .font(.title)
                ActiveView(isActive: user.isActive)
            }
            Text("Age: \(user.age)")
            Text("Company: \(user.company)")
            Text("Email: \(user.email)")
            Text("Address: \(user.address)")
            Text("Registered \(user.formattedDate)")
            Divider()
            Text(user.about)
            Divider()
            Section("Tags:") {
                HStack {
                    ForEach(user.tags, id: \.self) { tag in
                        Text("#\(tag)")
                    }
                }
                .padding(.bottom, 1)
            }
            
            Section("Friends:") {
                ForEach(user.friends, id: \.id) { friend in
                    Text(friend.name)
                }
            }
        }
        .padding()
    }
}

#Preview {
    let user = User(id: UUID(), isActive: true, name: "Ash", age: 10, company: "Masters", email: "ashketchem@pokecenter.com", address: "Pallet Town", about: "He set off on his journey with his starter Pikachu", registered: .now, tags: ["Pokemon","Gotta catch em all"], friends: [Friend(id: UUID(), name: "Pikachu")])
    DetailView(user: user)
}
