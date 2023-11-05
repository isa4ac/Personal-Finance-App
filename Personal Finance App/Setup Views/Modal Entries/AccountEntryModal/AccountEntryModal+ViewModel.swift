//
//  AccountEntryModal+ViewModel.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/3/23.
//

import Foundation
import SwiftUI

extension AccountEntryModal {
    class ViewModel: ObservableObject {
        @Published var nameInvalid = false
        @Published var balanceInvalid = false
        @Published var interestInvalid = false
        
        func getSize(accountType: AccountType) -> CGSize {
            if accountType == .Loan || accountType == .Savings {
                return CGSize(width: 325, height: 275)
            }
            return CGSize(width: 325, height: 225)
        }
        
        func entriesValid(_ name: String, _ balance: String, _ interest: String, checkInterest: Bool) -> Bool {
            if name.isEmpty {
                nameInvalid = true
                return false
            }
            nameInvalid = false
            if balance.isEmpty {
                balanceInvalid = true
                return false
            }
            balanceInvalid = false
            if checkInterest && interest.isEmpty {
                interestInvalid = true
                return false
            }
            interestInvalid = false
            return true
        }
    }
}
