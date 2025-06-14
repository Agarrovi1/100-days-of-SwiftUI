//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Angela Garrovillas on 4/2/25.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
