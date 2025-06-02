//
//  DetailView.swift
//  ActivityTracker
//
//  Created by Angela Garrovillas on 4/10/25.
//

import SwiftUI

struct DetailView: View {
    @State var activity: Activity
    var activities: Activities
    var body: some View {
        Section {
            Text(activity.title)
                .font(.title)
            Spacer()
            Text(activity.description)
            Text("\(activity.activityAmount()) \(activity.unit) completed")
            Spacer()
            Spacer()
            Spacer()
            Button("Completed activity, add to count") {
                activity.activityCompleted()
                saveChanges()
            }
        }
    }
    func saveChanges() {
        if let index = activities.items.firstIndex(where: { item in
            item.id == activity.id
        }) {
            activities.items[index] = activity
        }
        return
    }
}

#Preview {
    let ex = Activity(title: "Something", description: "Ipsum", unit: "question")
    DetailView(activity: ex, activities: Activities())
}
