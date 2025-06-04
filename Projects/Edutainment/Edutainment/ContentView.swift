//
//  ContentView.swift
//  Edutainment
//
//  Created by Angela Garrovillas on 4/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentNumber = 2
    @State private var questionAmounts = [5,10,20]
    @State private var currentQAmount = 5
    @State private var questionsAnswered = 0
    @State private var answer = 0
    @State private var score = 0
    @State private var firstNum: Int = 0
    @State private var secondNum: Int = 0
    @State private var showingAlert = false
    var body: some View {
        VStack {
            Stepper("Multiplication table up to... \(currentNumber)", value: $currentNumber, in: 2...12)
            Section("How many questions?") {
                Picker("Select question amount", selection: $currentQAmount) {
                    ForEach(questionAmounts, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
            }
            Spacer()
            //TODO: when at end and showing alert shows more than question amount like "Question 6/5" need to fix
            Text("Question \(questionsAnswered + 1) / \(currentQAmount)")
                .font(.title)
            Spacer()
            Section {
                Text("\(firstNum) x \(secondNum)")
                    .font(.title)
                Section("Type your answer here") {
                    TextField("Answer", value: $answer, format: .number)
                        .keyboardType(.numberPad)
                        .onSubmit {
                            nextQuestion(currentAnswer: answer)
                            answer = 0
                        }
                }
            }
            Spacer()
        }
        .padding()
        .onAppear(perform: newQuestion)
        .alert("Your score is \(score)", isPresented: $showingAlert) {
            Button("Start Over") {
                questionsAnswered = 0
                score = 0
                newQuestion()
            }
        }
    }
    func newQuestion() {
        firstNum = Int.random(in: 1...12)
        secondNum = Int.random(in: 1...currentNumber)
    }
    func nextQuestion(currentAnswer: Int) {
        if currentAnswer == firstNum * secondNum {
            score += 1
        }
        newQuestion()
        questionsAnswered += 1
        if questionsAnswered == currentQAmount {
            showingAlert = true
        }
    }
}

#Preview {
    ContentView()
}
