//
//  SetupView.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/1/23.
//

import Foundation
import SwiftUI

struct SetupView: View {
    @StateObject var viewModel = ViewModel()
    @State private var path = NavigationPath()
    var body: some View {
        ZStack {
            NavigationStack {
                accountList
                    .navigationTitle("Budget Setup")
                // Button to add a new incomes
                // options such as:
                // income name (optional)
                // monthly ammount
                
                // Button to add recurring expenses
                // options such as:
                // expense name (optional)
                // expense catagory
                // give way of showing suggestions
            }
            if viewModel.showAddAccountInputs {
                AccountEntryModal(name: $viewModel.newAccountName, type: $viewModel.newAccountType, balance: $viewModel.newAccountBalance, interest: $viewModel.newAccountInterest, isOpen: $viewModel.showAddAccountInputs, onSubmit: {
                    viewModel.addAccount()
                    viewModel.showAddAccountInputs = false
                })
            }
        }
        .onAppear {
            viewModel.getAccounts()
        }
    }
}

