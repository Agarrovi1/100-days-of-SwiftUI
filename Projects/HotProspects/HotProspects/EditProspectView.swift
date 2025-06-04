//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Angela Garrovillas on 5/7/25.
//

import SwiftData
import SwiftUI

struct EditProspectView: View {
    
    @Bindable var prospect: Prospect
    
    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
            TextField("Email", text: $prospect.emailAddress)
        }
        .navigationTitle("Edit Prospect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let prospect = Prospect(name: "Ash", emailAddress: "Pallet@PokeCenter.com", isContacted: true)
        return EditProspectView(prospect: prospect)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container \(error.localizedDescription)")
    }
}
