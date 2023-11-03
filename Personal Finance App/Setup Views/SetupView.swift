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
        ZStack {
            Color("Cell")
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    // List of accounts
                    VStack(spacing: 0) {
                        ForEach(viewModel.accounts, id: \.id) { account in
                            AccountRow(account: account)
                        }
                        MainButton(text: "+ Add Account", action: {
                            withAnimation(.linear(duration: 0.3)) {
                                viewModel.showAddAccountInputs = true
                            }
                            // on submit of modal view append to viewModel.accounts
                            
                            // once working, try implementing animation
                        })
                    }
                    .cornerRadius(20)
                    .padding()
                        
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
                .onAppear {
                    viewModel.getAccounts()
                }
            }
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

