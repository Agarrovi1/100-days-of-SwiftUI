//
//  ContentView.swift
//  BetterRest
//
//  Created by Angela Garrovillas on 3/26/25.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    private var idealBedtime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return "Your ideal sleep time is \(sleepTime.formatted(date: .omitted, time: .shortened))"
        
        } catch {
            
        }
        return "Sorry, there was a problem calculating your ideal sleep time"
    }
    
    @State private var wakeUp = defaultWakeTime
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    //Text("When do you want to wake up?")
                       // .font(.headline)
                    DatePicker("Please pick a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                        ForEach(0..<21) { num in
                            Text(num == 1 ? "1 cup" : "\(num) cups")
                        }
                    }
                }
                Text(idealBedtime)
                    .font(.largeTitle)
            }
            .navigationTitle("BetterRest")
//            .toolbar {
                //Button("Calculate", action: calculateBedtime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK") {}
//            } message: {
//                Text(alertMessage)
//            }
        }
        .padding()
        
        
//        VStack {
//            Stepper(" \(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
//            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
//                //.labelsHidden()
//            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
//            Text(Date.now, format: .dateTime.hour().minute())
//            Text(Date.now, format: .dateTime.day().month().year())
//            Text(Date.now.formatted(date: .long, time: .shortened))
//        }
//            .padding()
    }
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            print(sleepTime)
            
            //idealBedtime = "Your ideal sleep time is \(sleepTime.formatted(date: .omitted, time: .shortened))"
            
            //alertTitle = "Your ideal sleep time is..."
            //alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            //alertTitle = "Error"
            //alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        //showingAlert = true
    }
    func exampleDates() {
        //create a second Date instance to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)
        
        //create a range from now to tomorrow
        let range = Date.now...tomorrow
        print(range)
        //making a date from components
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? .now
        
        //getting values from a date's components
        let dateComponents = Calendar.current.dateComponents([.hour,.minute], from: date)
        let hour = dateComponents.hour ?? 0
        let minutes = dateComponents.minute ?? 0
        print(dateComponents)
        print(hour)
        print(minutes)
    }
}

#Preview {
    ContentView()
}
