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
    
    var body: some View {
        HStack(alignment: .center) {
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
//        .padding(.horizontal)
//        .background(Color)
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
