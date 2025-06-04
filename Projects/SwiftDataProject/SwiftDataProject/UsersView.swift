//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Angela Garrovillas on 4/17/25.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)
                
                Spacer()
                Text(String(user.jobs.count))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
    }
    
//    init(minimumJoinDate: Date) {
        //underscore "_" is for looking at/ affecting Query instead of assigning to the users property
//        _users = Query(filter: #Predicate<User> { user in
//            user.joinDate >= minimumJoinDate
//        }, sort: \User.name)
//    }
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
    func addSample() {
        let user = User(name: "Joy", city: "Pewter", joinDate: .now)
        let job1 = Job(name: "Heal pokemon", priority: 3)
        let job2 = Job(name: "Check ranch pokemon", priority: 4)
        modelContext.insert(user)
        user.jobs.append(job1)
        user.jobs.append(job2)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
