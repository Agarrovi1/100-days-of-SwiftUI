//
//  ContentView.swift
//  DiceRoll
//
//  Created by Angela Garrovillas on 5/14/25.
//

import SwiftUI

struct ContentView: View {
    let diceSides = [4,6,8,10,12,20,100]
    let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
    @State private var selectedDie = 4
    @State private var currentRoll = 0
    @State private var diceRecord = DiceRecords(sidesToTotal: [:])
    var body: some View {
        Form {
            Section {
                Picker("\(selectedDie) sided die", selection: $selectedDie) {
                    ForEach(diceSides, id: \.self) { sides in
                        Text(String(sides))
                    }
                }
                .onChange(of: selectedDie) {
                    currentRoll = 0
                }
                Button("Roll Die") {
                    currentRoll = Int.random(in: 1...selectedDie)
                    if let value = diceRecord.sidesToTotal[selectedDie] {
                        diceRecord.sidesToTotal[selectedDie] = value + currentRoll
                    } else {
                        diceRecord.sidesToTotal[selectedDie] = currentRoll
                    }
                }
            }
            Section {
                Text("Current roll: \(currentRoll)")
                Text("Total: \(diceRecord.sidesToTotal[selectedDie] ?? 0)")
            }
        }
        .onAppear(perform: load)
    }
    func save() {
        do {
            let data = try JSONEncoder().encode(diceRecord)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    func load() {
        do {
            let data = try Data(contentsOf: savePath)
            diceRecord = try JSONDecoder().decode(DiceRecords.self, from: data)
        } catch {
            diceRecord = DiceRecords(sidesToTotal: [:])
        }
    }
}

#Preview {
    ContentView()
}
