//
//  ContentView.swift
//  FaceReminder
//
//  Created by Angela Garrovillas on 5/1/25.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $viewModel.selectedImage) {
                    if let processedImage = viewModel.processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Touch to import photo"))
                    }
                }
                .onChange(of: viewModel.selectedImage, viewModel.importImage)
                
                TextField("Enter a name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit(viewModel.createPic)
            }
            .padding()
            .alert("Please enter a name", isPresented: $viewModel.showAlert) {}
            .navigationTitle("FaceReminder")
            .toolbar {
                NavigationLink {
                    ListView(pictures: viewModel.pictures.sorted())
                } label: {
                    Text("List")
                }
                .disabled(viewModel.name == "")
            }
        }
        
    }
    
}

#Preview {
    ContentView()
}
