//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Angela Garrovillas on 4/29/25.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "zeynep-sumer-lk3F07BN8T8-unsplash",
        "roonz-nl-ATgfRqpFfFI-unsplash",
        "matt-0KLPrQNEnQ4-unsplash",
        "ameenfahmy-gcWd0ts4RCo-unsplash"
    ]
    let labels = [
        "Sunflower",
        "Tulip",
        "Lily",
        "Rose"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    @State private var value = 10
    
    var body: some View {
        
        //MARK: Handling Voice Input
        Button("Tap Me") {
            print("Button tapped")
        }
        //can be activated by saying "Press Tap Me"
        
        Button("John Fitzgerald Kennedy") {
            print("Button tapped")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
        //Can be activated by saying any of these options
        
        //MARK: Reading the value of controls
//        VStack {
//                    Text("Value: \(value)")
//
//                    Button("Increment") {
//                        value += 1
//                    }
//
//                    Button("Decrement") {
//                        value -= 1
//                    }
//                }
//        .accessibilityElement()
//        .accessibilityLabel("Value")
//        .accessibilityValue(String(value))
//        .accessibilityAdjustableAction { direction in
//            switch direction {
//            case .increment:
//                value += 1
//            case .decrement:
//                value -= 1
//            default:
//                print("Not handled.")
//            }
//        }
        
        //MARK: Hiding and Grouping accessibility data
//        VStack {
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }
//        .accessibilityElement(children: .ignore)
//        .accessibilityLabel("Your score is 1000")
        
//        Image(.fugue)
//            .accessibilityHidden(true)
//        
//        Image(decorative: "Fugue")
        
        
        
        //MARK: Identifying views with useful labels
//        Button {
//            selectedPicture = Int.random(in: 0...3)
//        } label: {
//            Image(pictures[selectedPicture])
//                .resizable()
//                .scaledToFit()
//        }
//        .accessibilityLabel(labels[selectedPicture])
        
//        Image(pictures[selectedPicture])
//                    .resizable()
//                    .scaledToFit()
//                    .onTapGesture {
//                        selectedPicture = Int.random(in: 0...3)
//                    }
//                    .accessibilityLabel(labels[selectedPicture])
//                    .accessibilityAddTraits(.isButton)
//                    .accessibilityRemoveTraits(.isImage)
    }
}

#Preview {
    ContentView()
}
