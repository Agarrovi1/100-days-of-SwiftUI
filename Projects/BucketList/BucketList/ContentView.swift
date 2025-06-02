//
//  ContentView.swift
//  BucketList
//
//  Created by Angela Garrovillas on 4/24/25.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    var firstName: String
    var lastName: String

    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

enum LoadedStates {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}
struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}
struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

//struct Location: Identifiable {
//    let id = UUID()
//    var name: String
//    var coordinate: CLLocationCoordinate2D
//}

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    @State private var loadingState = LoadedStates.loading
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
//    let locations = [
//        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
//    ]
    
    @State private var isUnlocked = false
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
//    @State private var locations = [Location]()
//    @State private var selectedPlace: Location?
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
            if viewModel.isUnlocked {
                VStack {
                    MapReader { proxy in
                        Map(initialPosition: startPosition) {
                            ForEach(viewModel.locations) { location in
                                Annotation(location.name, coordinate: location.coordinate) {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .onLongPressGesture {
                                            viewModel.selectedPlace = location
                                            print("long tap")
                                        }
                                }
                            }
                        }
                        .mapStyle(viewModel.mapisHybrid ? .hybrid : .standard)
                        .sheet(item: $viewModel.selectedPlace) { place in
                            EditView(location: place) {
                                viewModel.update(location: $0)
                                //                    if let index = viewModel.locations.firstIndex(of: place) {
                                //                        viewModel.locations[index] = newLocation
                                //                    }
                            }
                        }
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                viewModel.addLocation(at: coordinate)
                                //                        let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                                //                        viewModel.locations.append(newLocation)
                            }
                        }
                        Button(viewModel.mapisHybrid ? "standard" : "hybrid") {
                            viewModel.mapisHybrid.toggle()
                        }
                    }
                }
                
                
                
                
                //MARK: Touch ID and Face ID
                //        VStack {
                //            if isUnlocked {
                //                Text("Unlocked")
                //            } else {
                //                Text("Locked")
                //            }
                //        }
                //        .onAppear(perform: authenticate)
                
                //MARK: MapKit
                //Map()
                //Map(interactionModes: [.rotate, .zoom])
                //Map(interactionModes: [])
                //Map(initialPosition: position)
                //.mapStyle(.imagery)
                //.mapStyle(.hybrid)
                //        VStack {
                //
                //            Map {
                //                ForEach(locations) { location in
                //                    Marker(location.name, coordinate: location.coordinate)
                //                    Annotation(location.name, coordinate: location.coordinate) {
                //                        Text(location.name)
                //                                .font(.headline)
                //                                .padding()
                //                                .background(.blue)
                //                                .foregroundStyle(.white)
                //                                .clipShape(.capsule)
                //                    }
                //                    .annotationTitles(.hidden)
                //                }
                //            }
                //            MapReader { proxy in
                //                Map()
                //                    .onTapGesture { tapPosition in
                //                        if let coordinate = proxy.convert(tapPosition, from: .local) {
                //                            print(coordinate)
                //                        }
                //                    }
                //            }
                
                //            Map(position: $position)
                //                .mapStyle(.hybrid(elevation:.realistic))
                //                .onMapCameraChange(frequency: .continuous) { context in
                //                    print(context.region)
                //                }
                //                .onMapCameraChange { context in
                //                    print(context.region)
                //                }
                
                //            HStack(spacing: 50) {
                //                Button("Paris") {
                //                    position = MapCameraPosition.region(
                //                        MKCoordinateRegion(
                //                            center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
                //                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                //                        )
                //                    )
                //                }
                //
                //                Button("Tokyo") {
                //                    position = MapCameraPosition.region(
                //                        MKCoordinateRegion(
                //                            center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
                //                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                //                        )
                //                    )
                //                }
                //            }
                //        }
                
                
                //MARK: Switching view states with enums
                //        switch loadingState {
                //        case .loading:
                //            LoadingView()
                //        case .success:
                //            SuccessView()
                //        case .failed:
                //            FailedView()
                //        }
                
                //        if loadingState == .loading {
                //            LoadingView()
                //        } else if loadingState == .success {
                //            SuccessView()
                //        } else if loadingState == .failed {
                //            FailedView()
                //        }
                
                
                //        if Bool.random() {
                //            Rectangle()
                //        } else {
                //            Circle()
                //        }
                
                //MARK: Writing to documents directory
                //        Button("Read and Write") {
                //            let data = Data("Test Message".utf8)
                //            let url = URL.documentsDirectory.appending(path: "message.txt")
                //            do {
                //                try data.write(to: url, options: [.atomic,.completeFileProtection])
                //                let input = try String(contentsOf: url)
                //                print(input)
                //            } catch {
                //                print(error.localizedDescription)
                //            }
                //        }
            } else {
                Button("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        
    }
    func printDirectoryURL() {
        print(URL.documentsDirectory)
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

extension FileManager {
    func decode<T: Codable>(_ file: String) -> T {
        let url = URL.documentsDirectory.appending(path: "message.txt")
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        do {
            //try data.write(to: url, options: [.atomic, .completeFileProtection])
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
