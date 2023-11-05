//
//  UserEntryRow.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 10/31/23.
//

import SwiftUI
import Combine

struct UserEntryRow: View {
    var label: String
    var labelBold = false
    @Binding var entry: String
    var previewText = ""
    var format = BaseFormat.string
    var icon = String()
    var iconColor = Color(.red)
    
    var body: some View {
        HStack(alignment: .center) {
            if icon != String() {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
            }
            Text(label)
                .bold(labelBold)
            Spacer()
            if format == .currency {
                TextField("", text: $entry, prompt: Text(previewText))
                    .multilineTextAlignment(.trailing)
                    .numbersOnly($entry, isCurrency: true)
            } else if format == .percent {
                HStack {
                    TextField("", text: $entry, prompt: Text(previewText))
                        .multilineTextAlignment(.trailing)
                        .numbersOnly($entry, includeDecimal: true)
                    Text("%")
                }
            } else {
                TextField("", text: $entry, prompt: Text(previewText))
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    
    func getCurrencyFormat() -> Formatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
    
    func getPercentFormat() -> Formatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
}

enum BaseFormat {
    case string
    case currency
    case percent
}

//#Preview {
//    @State var entry = String()
//    UserEntryRow(label: "", entry: $entry)
//}
