//
//  EditView.swift
//  BucketList
//
//  Created by Angela Garrovillas on 4/25/25.
//

import SwiftUI

enum LoadingState {
    case loading, loaded, failed
}

struct EditView: View {
    @Environment(\.dismiss) var dismiss
//    var location: Location
    var onSave: (Location) -> Void

//    @State private var name: String
//    @State private var description: String
    
    @State private var viewModel: ViewModel
    
//    @State private var loadingState = LoadingState.loading
//    @State private var pages = [Page]()
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = State(initialValue: ViewModel(location: location))
        self.onSave = onSave

//        _name = State(initialValue: location.name)
//        _description = State(initialValue: location.description)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.location.name)
                    TextField("Description", text: $viewModel.location.description)
                }
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.location.name
                    newLocation.description = viewModel.location.description

                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
//    func fetchNearbyPlaces() async {
//        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
//
//        guard let url = URL(string: urlString) else {
//            print("Bad URL: \(urlString)")
//            return
//        }
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            // we got some data back!
//            let items = try JSONDecoder().decode(Result.self, from: data)
//
//            // success – convert the array values to our pages array
//            pages = items.query.pages.values.sorted()
//            loadingState = .loaded
//        } catch {
//            // if we're still here it means the request failed somehow
//            loadingState = .failed
//        }
//    }
}

#Preview {
    EditView(location: .example) { _ in }
}
