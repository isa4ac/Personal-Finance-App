//
//  Transaction Model.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/4/23.
//

import Foundation

struct TransactionModel: Codable {
    var id: Int
    var name: String?
    var recurring: Recurring?
    var recurringOn: Date?
    var amount: Double? // negative / postive
}

enum Recurring: String, Codable, CaseIterable, Identifiable {
    var id: Self { self }
    
    case Daily
    case Weekly
    case Biweekly
    case Monthly
    case Yearly
}

