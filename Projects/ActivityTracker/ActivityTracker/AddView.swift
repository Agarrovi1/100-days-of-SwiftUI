//
//  AddView.swift
//  ActivityTracker
//
//  Created by Angela Garrovillas on 4/10/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    var activities: Activities
    
    @State private var title = ""
    @State private var description = ""
    @State private var unit = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name of Activity", text: $title)
                TextField("Description", text: $description)
                TextField("Unit of activity, ex: questions, hours", text: $unit)
            }
            .toolbar {
                Button("Save") {
                    let newActivity = Activity(title: title, description: description, unit: unit)
                    activities.items.append(newActivity)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(activities: Activities())
}
