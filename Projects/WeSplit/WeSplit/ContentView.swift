//
//  ContentView.swift
//  WeSplit
//
//  Created by Angela Garrovillas on 3/20/25.
//

import SwiftUI

struct ContentView: View {
    //@State private var tapCount = 0
    //@State private var name = ""
    //let students = ["Ash", "Misty", "Brock"]
    //@State private var selectedStudent = "Ash"
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    //let tipPercentages = [10,15,20,25,0]
    
    @FocusState private var amountIsFocused: Bool
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD") )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Grand Total") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
        //Creating views in a loop
//        NavigationStack {
//            Form {
//                Picker("Select your student", selection: $selectedStudent) {
//                    ForEach(students, id: \.self) {
//                        Text($0)
//                    }
//                }
//
//            }
//        }
        
        
        //Binding state to UI
//        Form {
//            TextField("Enter your name", text: $name)
//            Text("You're name is \(name)")
//        }
        
        
        //Modifying Program State
//        Button("Tap Count: \(tapCount)") {
//            self.tapCount += 1
//        }
        
        
        //Adding a navigationBar
//        NavigationStack {
//            Form {
//                Section {
//                    Text("Hello, world!")
//                }
//            }
//            .navigationTitle("SwiftUI")
//            .navigationBarTitleDisplayMode(.inline)
//        }
        
        //basic Form
//        Form {
//            Text("Hello, World!")
//            Text("Hello, World!")
//        }
//        Section {
//            Text("Hello, World!")
//            Text("Hello, World!")
//        }
        
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
        .padding()
    }
}

#Preview {
    ContentView()
}
