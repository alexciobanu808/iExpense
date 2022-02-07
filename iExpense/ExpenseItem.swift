//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Alex Ciobanu on 2/7/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
