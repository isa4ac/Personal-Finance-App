//
//  SetupView+ViewModel.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/1/23.
//

import Foundation

extension SetupView {
    class ViewModel: ObservableObject {
        @Published var accounts = [AccountModel]()
        @Published var showAddAccountInputs = false
        @Published var newAccountName = String()
        @Published var newAccountType = AccountType.Checking
        @Published var newAccountBalance = String()
        @Published var newAccountInterest = String()
        
        func getAccounts() {
            let userDefaults = UserDefaults.standard
            do {
                let accounts = try userDefaults.getObject(forKey: "accounts", castTo: [AccountModel].self)
                self.accounts = accounts
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func addAccount() {
            let lastAccountId = accounts.last?.id ?? 0
            var newAccount = AccountModel(id: lastAccountId + 1)
            newAccount.name = newAccountName
            newAccount.type = newAccountType
            let formattedBalance = newAccountBalance.filter({ "0123456789.".contains($0) })
            newAccount.balance = round((Double(formattedBalance) ?? 0)*100)/100
            let formattedInterest = Double(newAccountInterest.filter({ "0123456789.".contains($0) }))
            let roundedInterest = round((formattedInterest ?? 0)*100)/100
            newAccount.interestRate = (roundedInterest/100) + 1
            accounts.append(newAccount)
            
            let userDefaults = UserDefaults.standard
            do {
                try userDefaults.setObject(accounts, forKey: "accounts")
            } catch {
                print(error.localizedDescription)
            }
            
            newAccountName = String()
            newAccountType = AccountType.Checking
            newAccountBalance = String()
            newAccountInterest = String()
        }
    }
}
