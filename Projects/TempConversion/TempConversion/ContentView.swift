//
//  ContentView.swift
//  TempConversion
//
//  Created by Angela Garrovillas on 3/21/25.
//

import SwiftUI

struct ContentView: View {
    enum Temperature: String {
        case kelvin = "Kelvin", celsius = "Celsius", fahrenheit = "Fahrenheit"
    }
    @State private var tempInput = 0
    @State private var tempInputUnit = Temperature.kelvin
    @State private var tempOutputUnit = Temperature.kelvin
    
    var conversion: Int {
        var output = tempInput
        if tempInputUnit == .kelvin {
            output -= 273
        }
        if tempOutputUnit == .fahrenheit {
            output = (output * 9 / 5) + 32
        }
        if tempInputUnit == .fahrenheit {
            output = (output - 32) * 5 / 9
        }
        if tempOutputUnit == .kelvin {
            output += 273
        }
        return output
    }
    
    let tempUnits: [Temperature] = [.kelvin,.celsius,.fahrenheit]
    var body: some View {
        Form {
            Section("Degrees \(tempInputUnit.rawValue)") {
                Picker("Temperature Unit", selection: $tempInputUnit) {
                    ForEach(tempUnits, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                TextField("Enter Temperature", value: $tempInput, format: .number)
                    .keyboardType(.numberPad)
            }
            Section("Degrees \(tempOutputUnit.rawValue)") {
                Picker("Temperature Unit", selection: $tempOutputUnit) {
                    ForEach(tempUnits, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                Text(conversion, format: .number)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
