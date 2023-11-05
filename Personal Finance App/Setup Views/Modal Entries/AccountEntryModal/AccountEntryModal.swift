//
//  AccountEntryModal.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/1/23.
//

import SwiftUI

struct AccountEntryModal: View {
    @StateObject var viewModel = ViewModel()
    @Binding var name: String
    @Binding var type: AccountType
    @Binding var balance: String
    @Binding var interest: String
    @Binding var isOpen: Bool
    @FocusState private var accountNameFocus: Bool
    var onSubmit: () -> ()
    
    var body: some View {
        ModalViewBuilder(size: viewModel.getSize(accountType: type), content: {
            Group {
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                        .onTapGesture {
                            isOpen = false
                        }
                }
                .listRowSeparator(.hidden)
                UserEntryRow(label: "Account Name",
                             entry: $name,
                             previewText: "Chase",
                             icon: viewModel.nameInvalid ? "exclamationmark" : String())
                .focused($accountNameFocus)
                HStack {
                    Picker("Account Type", selection: $type) {
                        ForEach(AccountType.allCases) { option in
                            Text(String(describing: option))
                        }
                    }
                }
                UserEntryRow(label: "Balance",
                             entry: $balance,
                             previewText: "$0.00",
                             format: .currency,
                             icon: viewModel.balanceInvalid ? "exclamationmark" : String())
                if type == .Loan || type == .Savings { // TO-DO add interest for credit
                    UserEntryRow(label: "Interest (APR)",
                                 entry: $interest,
                                 previewText: "0.00",
                                 format: .percent,
                                 icon: viewModel.interestInvalid ? "exclamationmark" : String())
                }
                MainButton(text: "Add Account", action: {
                    // validation logic here
                    if viewModel.entriesValid(name, balance, interest, checkInterest: type == .Loan || type == .Savings) {
                        // run onsubmit logic
                        onSubmit()
                        // close
                        isOpen = false
                    }
                })
                .listRowSeparator(.hidden)
            }
            .listRowBackground(Color.clear)
        })
        .onAppear {
            accountNameFocus = true
        }
    }
}

//#Preview {
//    @State var accountName = ""
//    @State var accountType = AccountType.Savings
//    @State var accountBalance = "1.00"
//    @State var interest = "0"
//    AccountEntryModal(name: $accountName, type: $accountType, balance: $accountBalance, interest: $interest)
//}
