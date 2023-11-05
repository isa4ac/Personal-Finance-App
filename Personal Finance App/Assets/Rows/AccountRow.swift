//
//  AccountRow.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/1/23.
//

import SwiftUI

struct AccountRow: View {
    var account: AccountModel
    var body: some View {
        HStack(alignment: .center) {
            Text(account.name ?? "")
            Spacer()
            VStack(alignment: .trailing) {
                Text(account.type?.rawValue ?? "")
                    .foregroundColor(Color("DetailText"))
                    .font(.footnote)
                if account.type != .Loan {
                    Text(getSymbol() + String(format: "%.02f", account.balance ?? 0.0))
                        .foregroundColor(Color("DetailText"))
                        .font(.footnote)
                } else {
                    Text("(" + getSymbol() + String(format: "%.02f", account.balance ?? 0.0) + ")")
                        .foregroundColor(Color("DetailText"))
                        .font(.footnote)
                }
                if account.interestRate ?? 0.0 > 1.0 {
                    Text(String(format: "%.02f%%", ((account.interestRate ?? 0.0)-1)*100))
                        .foregroundColor(Color("DetailText"))
                        .font(.footnote)
                }
            }
        }
    }
    func getSymbol() -> String {
        let locale = Locale.current
        return locale.currencySymbol ?? "$"
    }
}

//#Preview {
//    AccountRow(account: AccountModel(from: Data() as! Decoder))
//}
