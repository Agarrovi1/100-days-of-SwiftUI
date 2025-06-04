//
//  CardView.swift
//  Flashzilla
//
//  Created by Angela Garrovillas on 5/8/25.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    @State private var offset = CGSize.zero
    let card: Card
    @State private var isShowingAnswer = false
    
    var removal: (() -> Void)? = nil
    //var addCardBack: (() -> Void)? = nil

        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        accessibilityDifferentiateWithoutColor
                            ? .white
                            : .white
                                .opacity(1 - Double(abs(offset.width / 50)))

                    )
                    .background(
                        accessibilityDifferentiateWithoutColor
                            ? nil
                            : RoundedRectangle(cornerRadius: 25)
                                //.fill(offset.width > 0 ? .green : .red)
                            .fill(fillColor(offset: offset))
                            
                    )
                    .shadow(radius: 10)
                VStack {
                    if accessibilityVoiceOverEnabled {
                        Text(isShowingAnswer ? card.answer : card.prompt)
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    } else {
                        Text(card.prompt)
                            .font(.largeTitle)
                            .foregroundStyle(.black)

                        if isShowingAnswer {
                            Text(card.answer)
                                .font(.title)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .frame(width: 450, height: 250)
            .rotationEffect(.degrees(offset.width / 5.0))
            .offset(x: offset.width * 5)
            .opacity(2 - Double(abs(offset.width / 50)))
            .accessibilityAddTraits(.isButton)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        if abs(offset.width) > 100 {
                            removal?()
                            //addCardBack?()
                        } else {
                            offset = .zero
                        }
                    }
            )
            .onTapGesture {
                isShowingAnswer.toggle()
            }
            .animation(.bouncy, value: offset)
        }
    func fillColor(offset: CGSize) -> Color {
        if offset.width < 0 {
            return .red
        } else if offset.width > 0 {
            return .green
        }
        return .white
    }
}

#Preview {
    CardView(card: .example)
}
