//
//  ContentView-ViewModel.swift
//  FaceReminder
//
//  Created by Angela Garrovillas on 5/1/25.
//

import SwiftUI
import PhotosUI

extension ContentView {
    @Observable
    class ViewModel {
        var processedImage: Image?
        var selectedImage: PhotosPickerItem?
        var currentPicture: Picture?
        var showAlert = false
        var name = ""
        var picData: Data?
        var pictures: [Picture] = []
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        let locationFetcher = LocationFetcher()
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                pictures = try JSONDecoder().decode([Picture].self, from: data)
            } catch {
                pictures = []
            }
        }
        
        func importImage() {
            Task {
                guard let imageData = try await selectedImage?.loadTransferable(type: (Data.self)) else { return }
                guard let inputImage = UIImage(data: imageData) else { return }
                
                processedImage = Image(uiImage: inputImage)
                picData = imageData
                locationFetcher.start()
                showAlert = true
            }
        }
        func createPic() {
            if let picData = picData {
                if let lastKnownLocation = locationFetcher.lastKnownLocation {
                    let pic = Picture(name: name, data: picData, latitude: lastKnownLocation.latitude, longitude: lastKnownLocation.longitude)
                    currentPicture = pic
                    pictures.append(pic)
                    save()
                } else {
                    print("couldn't find last known location")
                    let pic = Picture(name: name, data: picData, latitude: 0.0, longitude: 0.0)
                    currentPicture = pic
                    pictures.append(pic)
                    save()
                }
                
            }
        }
        func save() {
            do {
                let data = try JSONEncoder().encode(pictures)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}
