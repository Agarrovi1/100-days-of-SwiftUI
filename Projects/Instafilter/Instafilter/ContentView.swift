//
//  ContentView.swift
//  Instafilter
//
//  Created by Angela Garrovillas on 4/21/25.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
//    {
//        didSet {
//            print("new value is: \(blurAmount)")
//        }
//    }
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    @State private var image: Image?
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    let example = Image(.fugue)
    
    @Environment(\.requestReview) var requestReview
    
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var radiusIntesity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilters = false
    @AppStorage("filterCount") var filterCount = 0
    let context = CIContext()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Touch to import photo"))
                    }
                }
                .onChange(of: selectedItem, importImage)
                
                Spacer()
                
                HStack {
                    Text("Filter Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                        .disabled(processedImage == nil)
                }
                .padding(.vertical)
                
                HStack {
                    Text("Radius Intensity")
                    Slider(value: $radiusIntesity)
                        .onChange(of: radiusIntesity, applyProcessing)
                        .disabled(processedImage == nil)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change filter", action: changeFilter)
                        .disabled(processedImage == nil)
                    
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal,.bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Bloom") {setFilter(CIFilter.bloom())}
                Button("Crystallize") {setFilter(CIFilter.crystallize())}
                Button("Disc Blur") {setFilter(CIFilter.discBlur())}
                Button("Edges") {setFilter(CIFilter.edges())}
                Button("Gaussian Blur") {setFilter(CIFilter.gaussianBlur())}
                Button("Pixallate") {setFilter(CIFilter.pixellate())}
                Button("Sepia Tone") {setFilter(CIFilter.sepiaTone())}
                Button("Unsharp Map") {setFilter(CIFilter.unsharpMask())}
                Button("Vibrance") {setFilter(CIFilter.vibrance())}
                Button("Vignette") {setFilter(CIFilter.vignette())}
                Button("Cancel", role: .cancel) {}
            }
        }
        
        //MARK: App Store Review
//        Button("Leave a review") {
//            requestReview()
//        }
        
        //MARK: ShareLink
//        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!)
//        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!, subject: Text("Learn Swift Here"), message: Text("Check out the 100 days of SwiftUI"))
//        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
//            Label("Spread the word about Swift", systemImage: "swift")
//        }
//        ShareLink(item: example, preview: SharePreview("Honkai Star Rail: Fugue", image: example)) {
//            Label("Click to share", systemImage: "star")
//        }
        
        
        //MARK: loading photos from user's photo library
//        VStack {
//            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
//                .padding()
//            PhotosPicker(selection: $pickerItems,maxSelectionCount: 3, matching: .any(of: [.images, .not(.screenshots)])) {
//                Label("Select pictures", systemImage: "photo")
//            }
//            selectedImage?
//                .resizable()
//                .scaledToFit()
//            ScrollView {
//                ForEach(0..<selectedImages.count, id: \.self) { i in
//                    selectedImages[i]
//                        .resizable()
//                        .scaledToFit()
//                }
//            }
//        }
//        .onChange(of: pickerItem) {
//            Task {
//                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
//                
//            }
//        }
//        .onChange(of: pickerItems) {
//            Task {
//                selectedImages.removeAll()
//                for item in pickerItems {
//                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
//                        selectedImages.append(loadedImage)
//                    }
//                }
//            }
//        }
        
        //MARK: ContentUnavailableView
//        ContentUnavailableView("No snippets", systemImage: "swift", description: Text("You don't have any saved snippets yet"))
//        ContentUnavailableView {
//            Label("No snippets", systemImage: "swift")
//        } description: {
//            Text("You don't have any saved snippets yet")
//        } actions: {
//            Button("Create Snippet") {
//                //create snippet
//            }
//            .buttonStyle(.borderedProminent)
//        }
        
        //MARK: Core Image
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//        }
//        .onAppear(perform: loadImage)
        
        //MARK: Confirmation Dialog
//        Button("Hello Confirmation") {
//            showingConfirmation = true
//        }
//        .frame(width: 300, height: 300)
//        .background(backgroundColor)
//        .confirmationDialog("Change background", isPresented: $showingConfirmation) {
//            Button("Red") { backgroundColor = .red }
//            Button("Green") { backgroundColor = .green }
//            Button("Blue") { backgroundColor = .blue }
//            Button("Cancel", role: .cancel) { }
//        } message: {
//            Text("Select new color")
//        }
        
        //MARK: State changes
//        VStack {
//            Text("Hello, world!")
//                .blur(radius: blurAmount)
//            
//            Slider(value: $blurAmount, in: 0...20)
//                .onChange(of: blurAmount) { oldValue, newValue in
//                    print("new value is: \(newValue)")
//                }
            
//            Button("Random blur") {
//                blurAmount = Double.random(in: 0...20)
//            }
//        }
    }
    func loadImage() {
        //image = Image(.fugue)
        
        let inputImage = UIImage(resource: .fugue)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        //let currentFilter = CIFilter.sepiaTone()
        //currentFilter.inputImage = beginImage
        //currentFilter.intensity = 1
        
        //let currentFilter = CIFilter.pixellate()
        //currentFilter.inputImage = beginImage
        //currentFilter.scale = 100
        
        
//        let currentFilter = CIFilter.crystallize()
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 200
        let filter = CIFilter.colorInvert()
        
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage
//        currentFilter.radius = 1000
//        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
        let amount = 1.0
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
        //can now carry the twirl to any other filter
        
        
        
        //get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
        //attempt to get CGImage from CIImage
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        //convert that to UIImage
        let uiImage = UIImage(cgImage: cgImage)
        
        //and convert that to SwiftUI Image
        image = Image(uiImage: uiImage)
    }
    
    func changeFilter() {
        showingFilters = true
    }
    func importImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: (Data.self)) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radiusIntesity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputAmountKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputAmountKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        importImage()
        
        filterCount += 1
        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
