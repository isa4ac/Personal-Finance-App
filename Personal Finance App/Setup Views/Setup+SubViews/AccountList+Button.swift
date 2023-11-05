//
//  AccountList+Button.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/4/23.
//

import Foundation
import SwiftUI

extension SetupView {
    var accountList: some View {
            List {
                Section(header: Text("Accounts")) {
                ForEach(viewModel.accounts, id: \.id) { account in
                    AccountRow(account: account)
                        .frame(height: 50)
                }
                .onDelete(perform: viewModel.deleteAccount)
                MainButton(text: "+ Add Account", action: {
                    withAnimation(.linear(duration: 0.3)) {
                        viewModel.showAddAccountInputs = true
                    }
                })
            }
        }
        .environment(\.defaultMinListRowHeight, 50)
    }
}
