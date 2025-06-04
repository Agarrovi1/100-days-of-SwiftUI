//
//  ContentView.swift
//  iExpense
//
//  Created by Angela Garrovillas on 4/2/25.
//

import Observation
import SwiftData
import SwiftUI
//@Observable
//class User {
//    var firstName = "Bilbo"
//    var lastName = "Baggins"
//}
struct User: Codable {
    var firstName: String
    var lastName: String
}

struct SecondView: View {
    let name: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Hello, \(name)!")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

@Model
class Expense {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.amount = amount
    }
}

struct ColorBar: View {
    var amount: Double
    var body: some View {
        if amount < 10 {
            Color.mint
                .frame(width: 20)
        } else if amount < 100 {
            Color.green
                .frame(width: 100)
        } else {
            Color.red
                .frame(maxWidth: .infinity)
        }
    }
}

struct ContentView: View {
    @State private var user = User(firstName: "Bilbo", lastName: "Baggins")
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    //@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCount = 0
    //the string is the key but doesn't have to match the variable name
    @Query private var expenses: [Expense]
    @State private var showingAddExpense = false
    
    @Environment(\.modelContext) var modelContext
    
    @State private var sortOrder: [SortDescriptor<Expense>] = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]
    
    @State private var filterOption = "All"
    
    var body: some View {
        
        NavigationStack {
            ExpenseView(filterOption: filterOption, sortOrder: sortOrder)
            .toolbar {
//                Button("Add Expense", systemImage: "plus") {
//                    showingAddExpense = true
//                }
                NavigationLink {
                        AddView()
                } label: {
                    Image(systemName: "plus")
                }
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\Expense.name),
                                SortDescriptor(\Expense.amount)
                            ])
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.name)
                            ])
                    }
                }
                Menu("Filter", systemImage: "gear") {
                    Picker("Filter", selection: $filterOption) {
                        Text("All")
                            .tag("All")
                        Text("Personal")
                            .tag("Personal")
                        Text("Business")
                            .tag("Business")
                    }
                }
            }
//            NavigationLink {
//                    AddView(expenses: expenses)
//            } label: {
//                Image(systemName: "plus")
//            }
            .navigationTitle("iExpense")
//
        }
        
        //archiving with Codable
//        Button("Save user") {
//            let encoder = JSONEncoder()
//            if let data = try? encoder.encode(user) {
//                UserDefaults.standard.set(data, forKey: "UserData")
//            }
//        }
        
        //UserDefaults
//        Button("Tap count: \(tapCount)") {
//            tapCount += 1
//            //UserDefaults.standard.set(tapCount, forKey: "Tap")
//        }
        
//        //Deleting a row
//        NavigationStack {
//            VStack {
//                List {
//                    ForEach(numbers, id: \.self) {
//                        Text("Row \($0)")
//                    }
//                    .onDelete(perform: removeRows)
//                }
//                Button("Add number") {
//                    numbers.append(currentNumber)
//                    currentNumber += 1
//                }
//            }
//            .toolbar {
//                EditButton()
//            }
//        }
        
        
        //Showing a view with sheet
//        Button("Show sheet") {
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet) {
//            SecondView(name: user.firstName)
//        }
        
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName).")
//            TextField("First Name", text: $user.firstName)
//            TextField("Last Name", text: $user.lastName)
//        }
//        .padding()
    }
    func removeRows(at offsets: IndexSet) {
        //numbers.remove(atOffsets: offsets)
        //expenses.items.remove(atOffsets: offsets)
        for index in offsets {
            let item = expenses[index]
            modelContext.delete(item)
        }
    }
    func removePersonalRows(at offsets: IndexSet) {
        for index in offsets {
//            let item = personalExpenses[index]
//            let i = expenses.items.firstIndex {
//                $0.id == item.id
//            }
//            if let i = i {
//                expenses.items.remove(at: i)
//            }
            let item = expenses[index]
            modelContext.delete(item)
            
        }
    }
    func removeBusinessRows(at offsets: IndexSet) {
        for index in offsets {
//            let item = businessExpenses[index]
//            let i = expenses.items.firstIndex {
//                $0.id == item.id
//            }
//            if let i = i {
//                expenses.items.remove(at: i)
//            }
            let item = expenses[index]
            modelContext.delete(item)
            
        }
    }
}

#Preview {
    ContentView()
}
