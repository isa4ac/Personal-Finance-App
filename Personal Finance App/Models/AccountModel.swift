//
//  AccountModel.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/1/23.
//

import Foundation

struct AccountModel: Codable {
    var id: Int
    var name: String?
    var type: AccountType?
    var balance: Double?
    var interestRate: Double?
}

enum AccountType: String, Codable, CaseIterable, Identifiable {
    var id: Self { self }
    
    case Credit
    case Checking
    case Savings
    case Loan
    case Brokerage
}
