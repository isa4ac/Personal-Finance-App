//
//  AccountEntryModal.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/1/23.
//

import SwiftUI

struct AccountEntryModal: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    @Binding var name: String
    @Binding var type: AccountType
    @Binding var balance: String
    @Binding var interest: String
    @Binding var isOpen: Bool
    @FocusState private var accountNameFocus: Bool
    var onSubmit: () -> ()
    
    var body: some View {
        NavigationView {
            List {
                UserEntryRow(label: "Account Name", entry: $name, previewText: "Chase")
                    .focused($accountNameFocus)
                HStack {
//                    Text("Account Type")
//                    Spacer()
                    Picker("Account Type", selection: $type) {
                        ForEach(AccountType.allCases) { option in
                            Text(String(describing: option))
                        }
                    }
                }
                UserEntryRow(label: "Balance", entry: $balance, previewText: "$0.00", format: .currency)
                if type == .Loan || type == .Savings { // TO-DO add interest for credit
                    UserEntryRow(label: "Interest Rate", entry: $interest, previewText: "0.00", format: .percent)
                }
                MainButton(text: "Add Account", action: {
                    // validation logic here
                    
                    // run onsubmit logic
                    onSubmit()
                    
                    // close
                    isOpen = false
                })
            }
            .onAppear {
                accountNameFocus = true
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isOpen = false
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .navigationTitle("New Account")
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
