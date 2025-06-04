//
//  GridView.swift
//  Moonshot
//
//  Created by Angela Garrovillas on 4/10/25.
//

import SwiftUI

struct GridView: View {
    let mission: Mission
    var body: some View {
        VStack {
            Image(decorative: mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
        .accessibilityElement()
        .accessibilityLabel("\(mission.displayName) launch date: \(mission.formattedLaunchDate)")
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    GridView(mission: missions[0])
}
