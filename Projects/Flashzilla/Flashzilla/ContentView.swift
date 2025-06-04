//
//  ContentView.swift
//  Flashzilla
//
//  Created by Angela Garrovillas on 5/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    
    @State private var currentRotationAmount = Angle.zero
    @State private var finalRotationAmount = Angle.zero
    
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false
    
    //let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    //@Environment(\.scenePhase) var scenePhase
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    //@Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
//    @State private var cards = Array<Card>(repeating: .example, count: 10)
    @State private var cards = [Card]()
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
                VStack {
                    Text("Time: \(timeRemaining)")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(.black.opacity(0.75))
                        .clipShape(.capsule)
                    ZStack {
                        ForEach(0..<cards.count, id: \.self) { index in
                            CardView(card: cards[index]) {
                               withAnimation {
                                   removeCard(at: index)
                               }
                            }
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibilityHidden(index < cards.count - 1)
                        }
                    }
                    .allowsHitTesting(timeRemaining > 0)
                    if cards.isEmpty {
                        Button("Start Again", action: resetCards)
                            .padding()
                            .background(.white)
                            .foregroundStyle(.black)
                            .clipShape(.capsule)
                    }
                }
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()

//                    HStack {
//                        Image(systemName: "xmark.circle")
//                            .padding()
//                            .background(.black.opacity(0.7))
//                            .clipShape(.circle)
//                        Spacer()
//                        Image(systemName: "checkmark.circle")
//                            .padding()
//                            .background(.black.opacity(0.7))
//                            .clipShape(.circle)
//                    }
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")

                        Spacer()

                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
            }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
        //.sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
        .onReceive(timer) { time in
            guard isActive else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        
        //MARK: supporting specific accessibility needs
        
//        Text("Hello, World!")
//                    .padding()
//                    .background(reduceTransparency ? .black : .black.opacity(0.5))
//                    .foregroundStyle(.white)
//                    .clipShape(.capsule)
        
//        Button("Hello, World!") {
//                    withOptionalAnimation {
//                        scale *= 1.5
//                    }
//
//                }
//                .scaleEffect(scale)
        
//        Button("Hello, World!") {
//                    if reduceMotion {
//                        scale *= 1.5
//                    } else {
//                        withAnimation {
//                            scale *= 1.5
//                        }
//                    }
//
//                }
//                .scaleEffect(scale)
        
//        HStack {
//                    if differentiateWithoutColor {
//                        Image(systemName: "checkmark.circle")
//                    }
//
//                    Text("Success")
//                }
//                .padding()
//                .background(differentiateWithoutColor ? .black : .green)
//                .foregroundStyle(.white)
//                .clipShape(.capsule)
        
        //MARK: when your app moves to the background
//        Text("Hello, world!")
//                    .onChange(of: scenePhase) { oldPhase, newPhase in
//                        if newPhase == .active {
//                            print("Active")
//                        } else if newPhase == .inactive {
//                            print("Inactive")
//                        } else if newPhase == .background {
//                            print("Background")
//                        }
//                    }
        
        //MARK: Triggering events repeatedly with a timer
        //Text("Hello, World!")
//                    .onReceive(timer) { time in
//                        if counter == 5 {
//                            timer.upstream.connect().cancel()
//                        } else {
//                            print("The time is now \(time)")
//                        }
//
//                        counter += 1
//                    }
        
//        Text("Hello, World!")
//            .onReceive(timer) { time in
//                print("The time is now \(time)")
        //timer.upstream.connect().cancel()
//            }
        
        //MARK: AllowsHitTesting
        
//        VStack {
//            Text("Hello")
//            Spacer().frame(height: 100)
//            Text("World")
//        }
//        .contentShape(.rect)
//        .onTapGesture {
//            print("VStack tapped!")
//        }
        
//        VStack {
//            Text("Hello")
//            Spacer().frame(height: 100)
//            Text("World")
//        }
//        .onTapGesture {
//            print("VStack tapped!")
//        }
        
//        ZStack {
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle tapped!")
//                }
//
//            Circle()
//                .fill(.red)
//                .frame(width: 300, height: 300)
//                .contentShape(.rect)
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//                .allowsHitTesting(false)
            //makes it so when you tap on circle the rectangle gesture goes through instead
//        }
        
        //MARK: Gestures
        // a drag gesture that updates offset and isDragging as it moves around
//                let dragGesture = DragGesture()
//                    .onChanged { value in offset = value.translation }
//                    .onEnded { _ in
//                        withAnimation {
//                            offset = .zero
//                            isDragging = false
//                        }
//                    }

                // a long press gesture that enables isDragging
//                let pressGesture = LongPressGesture()
//                    .onEnded { value in
//                        withAnimation {
//                            isDragging = true
//                        }
//                    }

                // a combined gesture that forces the user to long press then drag
//                let combined = pressGesture.sequenced(before: dragGesture)

                // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
//                Circle()
//                    .fill(.red)
//                    .frame(width: 64, height: 64)
//                    .scaleEffect(isDragging ? 1.5 : 1)
//                    .offset(offset)
//                    .gesture(combined)
        
//        VStack {
//                    Text("Hello, World!")
//                        .onTapGesture {
//                            print("Text tapped")
//                        }
//                }
//                .simultaneousGesture(
//                    TapGesture()
//                        .onEnded {
//                            print("VStack tapped")
//                        }
//                )
        
//        VStack {
//                    Text("Hello, World!")
//                        .onTapGesture {
//                            print("Text tapped")
//                        }
//                }
//                .highPriorityGesture(
//                    TapGesture()
//                        .onEnded {
//                            print("VStack tapped")
//                        }
//                )
        
//        VStack {
//                    Text("Hello, World!")
//                        .onTapGesture {
//                            print("Text tapped")
//                        }
//                }
//                .onTapGesture {
//                    print("VStack tapped")
//                }
        
//        Text("Hello, World!Rotate")
//                    .rotationEffect(currentRotationAmount + finalRotationAmount)
//                    .gesture(
//                        RotateGesture()
//                            .onChanged { value in
//                                currentRotationAmount = value.rotation
//                            }
//                            .onEnded { value in
//                                finalRotationAmount += currentRotationAmount
//                                currentRotationAmount = .zero
//                            }
//                    )
        
//        Text("Hello, World! Magnify")
//                    .scaleEffect(finalAmount + currentAmount)
//                    .gesture(
//                        MagnifyGesture()
//                            .onChanged { value in
//                                currentAmount = value.magnification - 1
//                            }
//                            .onEnded { value in
//                                finalAmount += currentAmount
//                                currentAmount = 0
//                            }
//                    )
        
//        Text("Hello, World! Long press change")
//            .onLongPressGesture(minimumDuration: 1) {
//                print("Long pressed!")
//            } onPressingChanged: { inProgress in
//                print("In progress: \(inProgress)!")
//            }
//        Text("Hello, World! Long press 2")
//            .onLongPressGesture(minimumDuration: 2) {
//                print("Long pressed!")
//            }
//        Text("Hello, World! Long press")
//            .onLongPressGesture {
//                print("Long pressed!")
//            }
//        Text("Hello, World! Double tap")
//            .onTapGesture(count: 2) {
//                print("Double tapped!")
//            }
    }
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
//    func resetCards() {
//        cards = Array<Card>(repeating: .example, count: 10)
//        timeRemaining = 100
//        isActive = true
//    }
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

#Preview {
    ContentView()
}
