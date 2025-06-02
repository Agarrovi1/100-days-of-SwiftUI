//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Angela Garrovillas on 4/11/25.
//

import SwiftUI
import CoreHaptics

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name = "Taylor"
}

struct ContentView: View {
    @State private var results = [Result]()
    
    @State private var username = ""
    @State private var email = ""
    
    @State private var counter = 0
    @State private var engine: CHHapticEngine?
    
    @State private var order = Order()
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink("Delivery Details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
        
        //MARK: Adding Haptic Effects
//        Button("Tap me", action: complexSuccess)
//            .onAppear(perform: prepareHaptics)
        
//        Button("Tap count: \(counter)") {
//            counter += 1
//        }
        //.sensoryFeedback(.increase, trigger: counter)
        //.sensoryFeedback(.impact(flexibility: .soft), trigger: counter)
        //.sensoryFeedback(.impact(weight: .heavy), trigger: counter)
        
        //MARK: Codable conformance for @Observable classes
        //Button("Encode Taylor", action: encodeTaylor)
        
        //MARK: validating and disabling Form
//        Form {
//            Section {
//                TextField("Username", text: $username)
//                TextField("Email", text: $email)
//            }
//            Section {
//                Button("Create account") {
//                    print("creating account...")
//                }
//            }
//            //this section is disabled if username or email is empty
//            //.disabled(username.isEmpty || email.isEmpty)
//            .disabled(disableForm)
//        }
        
        //MARK: Loading an image from remote server
        //AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) {image in
//            image
//                .resizable()
//                .scaledToFit()
//        } placeholder: {
//            //Color.red
//            ProgressView()
//        }
//        .frame(width: 200, height: 200)
        
//        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
//            if let image = phase.image {
//                image
//                    .resizable()
//                    .scaledToFit()
//            } else if phase.error != nil {
//                Text("There was an error loading the image.")
//            } else {
//                ProgressView()
//            }
//        }
//        .frame(width: 200, height: 200)
            
        
        //MARK: Sending and receiving data with URLSession
//        List(results, id: \.trackId) { item in
//            VStack(alignment: .leading) {
//                Text(item.trackName)
//                    .font(.headline)
//                Text(item.collectionName)
//            }
//        }
//        .task {
//            await loadData()
//        }
    }
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid URL")
        }
    }
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str) //{"_name":"Taylor","_$observationRegistrar":{}}
        //with coding keys we get: {"name":"Taylor"}
    }
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    func complexSuccess() {
        //make sure the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        //create one intense, sharp tap
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
//            events.append(event)
        
        //get several taps of increasing then decreasing intensity and sharpness
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        //convert those events into a pattern and play it immediately
        do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play pattern: \(error.localizedDescription).")
            }
    }
}

#Preview {
    ContentView()
}
