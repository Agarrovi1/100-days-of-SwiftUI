//
//  DetailView.swift
//  FaceReminder
//
//  Created by Angela Garrovillas on 5/1/25.
//

import MapKit
import SwiftUI

struct DetailView: View {
    var picture: Picture
    var body: some View {
        VStack {
            Text(picture.name)
                .font(.title)
            if let uiImage = UIImage(data: picture.data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            Map(initialPosition: getInitialMapPosition()) {
                Marker(picture.name, coordinate: picture.coordinate)
            }
        }
        .padding()
    }
    func getInitialMapPosition() -> MapCameraPosition {
        return MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: picture.latitude, longitude: picture.longitude),
                span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
            )
        )
    }
}

#Preview {
    DetailView(picture: Picture(name: "", data: Data(), latitude: 0.0, longitude: 0.0))
}
