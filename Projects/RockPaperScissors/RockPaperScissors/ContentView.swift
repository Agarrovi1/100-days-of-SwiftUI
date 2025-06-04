//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Angela Garrovillas on 3/26/25.
//

import SwiftUI

/*
Image(systemName: "globe")
    .imageScale(.large)
    .foregroundStyle(.tint)
 */
enum RPS: String {
    case rock = "👊"
    case paper = "✋"
    case scissors = "✌️"
    
    static func random() -> RPS {
        
        return [.paper,.rock,.scissors].randomElement() ?? .paper
    }
    static func randomOrder() -> [RPS] {
        return [.paper,.rock,.scissors].shuffled()
    }
    static func winningMove(against input: RPS) -> RPS {
        switch input {
        case .paper:
            return .scissors
        case .rock:
            return .paper
        case .scissors:
            return .rock
        }
    }
}

struct ContentView: View {
    @State private var turn = 1
    @State private var compPick = RPS.random()
    @State private var shouldWin = Bool.random()
    @State private var playerScore = 0
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var playerChoices = RPS.randomOrder()
    @State private var gameOver = false
    
    var body: some View {
        VStack {
            Text("Player Score: \(playerScore)")
            Text("Player should \(shouldWin ? "win" : "lose")")
                .font(.title)
                .foregroundStyle(shouldWin ? .blue : .red)
                .multilineTextAlignment(.center)
            Spacer()
            Text("Computer chose \(compPick)")
            Text("\(compPick.rawValue)")
                .font(.system(size: 200))
            Spacer()
            HStack {
                ForEach(playerChoices, id: \.self) { choice in
                    Button {
                        if choice == RPS.winningMove(against: compPick) && shouldWin {
                            playerScore += 1
                            alertTitle = "Correct!"
                        } else if choice != .winningMove(against: compPick) && !shouldWin {
                            playerScore += 1
                            alertTitle = "Correct!"
                        } else {
                            alertTitle = "Wrong!"
                        }
                        if turn > 10 {
                            gameOver = true
                        } else {
                            showAlert = true
                        }
                    } label: {
                        Text(choice.rawValue)
                            .font(.system(size: 80))
                            .padding()
                    }
                }
            }
        }
        .padding()
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") {
                turn += 1
                newTurn()
            }
        }
        .alert("Game is over. Your score is \(playerScore)", isPresented: $gameOver) {
            Button("Restart", role: .destructive) {
                turn = 1
                playerScore = 0
                newTurn()
            }
        }
    }
    func newTurn() {
        compPick = RPS.random()
        playerChoices = RPS.randomOrder()
        shouldWin.toggle()
    }
}

#Preview {
    ContentView()
}
