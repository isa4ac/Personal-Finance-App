//
//  SetupView.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/1/23.
//

import Foundation
import SwiftUI

struct SetupView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack {
            List {
                Text("Accounts")
                    .font(.title2)
                    .bold()
                
                ForEach(viewModel.accounts, id: \.id) { account in
                    AccountRow(account: account)
                }
                .onDelete(perform: viewModel.deleteAccount)
                MainButton(text: "+ Add Account", action: {
                    withAnimation(.linear(duration: 0.3)) {
                        viewModel.showAddAccountInputs = true
                    }
                })
            }
            // Button to add a new incomes
            // options such as:
            // income name (optional)
            // monthly ammount
            
            // Button to add recurring expenses
            // options such as:
            // expense name (optional)
            // expense catagory
            // give way of showing suggestions
            .navigationTitle("Budget Setup")
        }
        .onAppear {
            viewModel.getAccounts()
        }
        .fullScreenCover(isPresented: $viewModel.showAddAccountInputs, content: {
            AccountEntryModal(name: $viewModel.newAccountName,
                              type: $viewModel.newAccountType,
                              balance: $viewModel.newAccountBalance,
                              interest: $viewModel.newAccountInterest,
                              isOpen: $viewModel.showAddAccountInputs,
                              onSubmit: {
                viewModel.addAccount()
                viewModel.getAccounts()
            })
        })
    }
}

