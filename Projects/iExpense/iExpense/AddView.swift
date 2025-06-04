//
//  AddView.swift
//  iExpense
//
//  Created by Angela Garrovillas on 4/3/25.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @State private var name = "Type Expense Name Here"
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var showingAlert = false
    
    let types = ["Business", "Personal"]
    @Query var expenses: [Expense]
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                //TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        guard name != "Type Expense Name Here" else {
                            showingAlert = true
                            return
                        }
                        let item = Expense(name: name, type: type, amount: amount)
                        //expenses.items.append(item)
                        modelContext.insert(item)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .alert("Please write in a name for expense", isPresented: $showingAlert) {
                Button("OK") {
                    
                }
            }
        }
    }
}

#Preview {
    AddView()
}
