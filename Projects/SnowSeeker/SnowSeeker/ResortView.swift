//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Angela Garrovillas on 5/15/25.
//

import SwiftUI

struct ResortView: View {
    
    let resort: Resort
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(Favorites.self) var favorites
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    Text("Image from: \(resort.imageCredit)")
                        .font(.subheadline)
                    
                    HStack {
                        if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                            VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                            VStack(spacing: 10) { SkiDetailsView(resort: resort) }
//                                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        } else {
                            ResortDetailsView(resort: resort)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .padding(.vertical)
                    .background(.primary.opacity(0.1))

                    Group {
                        Text(resort.description)
                            .padding(.vertical)

                        Text("Facilities")
                            .font(.headline)

                        HStack {
                            ForEach(resort.facilityTypes) { facility in
                                Button {
                                    selectedFacility = facility
                                    showingFacility = true
                                } label: {
                                    facility.icon
                                        .font(.title)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal)
                }
            }
        Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
            if favorites.contains(resort) {
                favorites.remove(resort)
            } else {
                favorites.add(resort)
            }
        }
        .buttonStyle(.borderedProminent)
        .padding()
            .navigationTitle("\(resort.name), \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
            .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
            } message: { facility in
                Text(facility.description)
            }
        }
}

#Preview {
    
    ResortView(resort: .example)
        .environment(Favorites())
}
