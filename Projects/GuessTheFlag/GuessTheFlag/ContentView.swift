//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Angela Garrovillas on 3/21/25.
//

import SwiftUI

struct FlagImage: View {
    var name: String
    
    var body: some View {
        Image(name)
        .clipShape(.capsule)
        .shadow(radius: 5)
    }
}

struct ContentView: View {
    //@State private var showingAlert = false
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland","Italy","Nigeria","Poland", "Spain", "UK","Ukraine","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var questionCount = 1
    @State private var buttonPressed = 0
    @State private var animationAmount = 0.0
    @State private var opacity = 1.0
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.headline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            buttonPressed = number
                            withAnimation { animationAmount += 360
                                opacity = 0.25
                            }
                        } label: {
                            FlagImage(name: countries[number])
                        }
                        .rotation3DEffect(buttonPressed == number ? .degrees(animationAmount) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                        .opacity(buttonPressed != number ? opacity : 1.0 )
                        .hueRotation(buttonPressed != number ? .degrees(animationAmount) : .degrees(0))
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
            .alert(scoreTitle, isPresented: $showingFinalScore) {
                Button("Restart",role: .destructive, action: reset)
            } message: {
                Text("Your final score is \(score)")
            }
            .padding()
        }
        //Showing Alert Messages
//        Button("Show Alert") {
//            showingAlert = true
//        }
//        .alert("Important Message", isPresented: $showingAlert) {
//            Button("Delete", role: .destructive) { }
//            Button("Cancel", role: .cancel) { }
//        } message: {
//            Text("Please read this")
//        }
        
        //Buttons and Images
//        VStack {
//            Button("Button 1") { }
//                .buttonStyle(.bordered)
//            Button("Button 2", role: .destructive) { }
//                .buttonStyle(.bordered)
//            Button("Button 3") { }
//                .buttonStyle(.borderedProminent)
//                .tint(.mint)
//            Button("Button 4", role: .destructive) { }
//                .buttonStyle(.borderedProminent)
//            Button {
//                print("Button was tapped")
//            } label: {
//                Text("Tap me!")
//                    .padding()
//                    .foregroundStyle(.white)
//                    .background(.red)
//            }
//            Button {
//                print("Edit button was tapped")
//            } label: {
//                Image(systemName: "pencil")
//            }
//            .padding()
//            Button ("Edit Button", systemImage: "pencil") {
//                print("Edit button tapped")
//            }
//            Button {
//                print("Another edit button tapped")
//            } label: {
//                Label("Edit", systemImage: "pencil")
//                    .padding()
//                    .foregroundStyle(.white)
//                    .background(.orange)
//            }
//        }
        
        //Button("Delete Section",role: .destructive, action: executeDelete)
        
        //Gradients
//        Text("Your Content")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .foregroundStyle(.white)
//            .background(.red.gradient)
        
        //AngularGradient(colors: [.red,.yellow,.green,.blue,.purple,.red], center: .center)
        
//        RadialGradient(colors: [.blue,.black], center: .center, startRadius: 20, endRadius: 200)
        
//        LinearGradient(stops: [
//            Gradient.Stop(color: .white, location: 0.45),
//            .init(color: .black, location: 0.55)
//        ], startPoint: .top, endPoint: .bottom)
        
        //Colors and Frames
//        ZStack {
//            VStack(spacing: 0) {
//                Color.red
//                Color.blue
//            }
//            Text("Your Content")
//                .foregroundStyle(.secondary)
//                .padding(50)
//                .background(.ultraThinMaterial)
//        }
        //.background(.red)
        //.ignoresSafeArea()
        //Using Stacks to Arrange Views
//        VStack(alignment: .leading, spacing: 20) {
//            Spacer()
//            Text("First")
//            Text("Second")
//            Text("Third")
//            Spacer()
//            Spacer()
//        }
//        HStack(spacing: 20) {
//            Text("Hello, World!")
//            Text("This is inside a HStack")
//        }
//        ZStack {
//            Text("Hello, World!")
//            Text("This is inside a ZStack")
//        }
        //.padding()
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        if questionCount >= 8 {
            showingFinalScore = true
        } else {
            showingScore = true
        }
        
    }
    func reset() {
        score = 0
        questionCount = 0
        askQuestion()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount += 1
        opacity = 1
    }
    
    func executeDelete() {
        print("Now deleting...")
    }
}


#Preview {
    ContentView()
}
