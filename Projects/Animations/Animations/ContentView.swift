//
//  ContentView.swift
//  Animations
//
//  Created by Angela Garrovillas on 3/31/25.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    //@State private var animationAmount = 1.0
    //@State private var animationAmount = 0.0
    
    let letters = Array("Hello SwiftUI")
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    @State private var isShowingRed = false
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
        
//        VStack {
//            Button("Tap me") {
//                withAnimation {
//                    isShowingRed.toggle()
//                }
//            }
//            
//            if isShowingRed {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200)
//                    //.transition(.scale)
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
//            }
//        }
        
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count, id: \.self) { num in
//                Text(String(letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(enabled ? .blue : .red)
//                    .offset(dragAmount)
//                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { dragAmount = $0.translation }
//                .onEnded { _ in
//                    dragAmount = .zero
//                    enabled.toggle()
//                }
//        )
        
//        LinearGradient(colors: [.yellow,.red], startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200)
//            .clipShape(.rect(cornerRadius: 10))
//            .offset(dragAmount)
//            .gesture(
//                DragGesture()
//                    .onChanged {
//                        dragAmount = $0.translation
//                    }
//                    .onEnded {
//                        _ in
//                        withAnimation(.bouncy) {
//                            dragAmount = .zero
//                        }
//                        //explicit animation that animates the release of the card
//                    }
//            )
            //.animation(.bouncy, value: dragAmount)
        
//        Button("Tap Me") {
////            withAnimation(.spring(duration: 1, bounce: 0.5)) {
//                animationAmount += 360
//                enabled.toggle()
////            }
//                }
//                .padding(50)
//                .background(enabled ? .blue : .red)
//                //.clipShape(.circle)
//                .animation(nil, value: enabled)
//                .foregroundStyle(.white)
//                .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
//                .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
                //.rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                
        
//        print(animationAmount)
//        return VStack {
//            Stepper("Scale amount", value: $animationAmount.animation(
//                .easeInOut(duration: 1)
//                .repeatCount(3, autoreverses: true)
//            ), in: 1...10)
//            Spacer()
//            Button("Tap Me") {
//                animationAmount += 1
//            }
//            .padding(40)
//            .background(.red)
//            .foregroundStyle(.white)
//            .clipShape(.circle)
//            .scaleEffect(animationAmount)
//        }
//        .padding()
//        .overlay(
//            Circle()
//                .stroke(.red)
//                .scaleEffect(animationAmount)
//                .opacity(2 - animationAmount)
//                .animation(
//                    .easeInOut(duration: 1)
//                    .repeatForever(autoreverses: false),
//                    //.repeatCount(3, autoreverses: true),
//                    //.delay(1),
//                    value: animationAmount
//                )
//        )
//        .onAppear {
//            animationAmount = 2
//        }
        //.animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
        //.blur(radius: (animationAmount - 1) * 3)
        //.animation(.default, value: animationAmount)
        //.animation(.linear, value: animationAmount)
    }
}

#Preview {
    ContentView()
}
