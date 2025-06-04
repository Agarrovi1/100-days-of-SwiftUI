//
//  ExpenseView.swift
//  iExpense
//
//  Created by Angela Garrovillas on 4/18/25.
//

import SwiftData
import SwiftUI

struct ExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var expenses: [Expense]
    
//    private var personalExpenses: [Expense] {
//        expenses.filter {$0.type == "Personal"}
//    }
//    private var businessExpenses: [Expense] {
//        expenses.filter {$0.type == "Business"}
//    }
    var body: some View {
        List {
            Section {
                ForEach(expenses/*, id: \.id*/) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            ColorBar(amount: item.amount)
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("\(item.name) \(item.amount, format:.currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    .accessibilityHint("\(item.type) expense")
                }
                .onDelete(perform: removeRows)
            }
//            Section("Business Expenses") {
//                ForEach(businessExpenses/*, id: \.id*/) { item in
//                    HStack {
//                        VStack(alignment: .leading) {
//                            ColorBar(amount: item.amount)
//                            Text(item.name)
//                                .font(.headline)
//                            Text(item.type)
//                            
//                        }
//                        Spacer()
//                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                    }
//                }
//                .onDelete(perform: removeRows)
//            }
        }
    }
    /*
     init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
         _users = Query(filter: #Predicate<User> { user in
             user.joinDate >= minimumJoinDate
         }, sort: sortOrder)
     }
     */
    init(filterOption: String, sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            if filterOption == "All" {
                return true
            } else {
                return expense.type == filterOption
            }
        },sort: sortOrder)
    }
    func removeRows(at offsets: IndexSet) {
        for index in offsets {
            let item = expenses[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ExpenseView(filterOption: "All", sortOrder: [SortDescriptor(\Expense.name)])
}
