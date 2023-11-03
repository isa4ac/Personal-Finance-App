//
//  NumberOnlyViewModifier.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/2/23.
//

import SwiftUI
import Combine

struct NumberOnlyViewModifier: ViewModifier {
    @Binding var text: String
    var isCurrency: Bool = false
    var includeDecimal: Bool = false
    
    func body(content: Content) -> some View {
        content
            .keyboardType(includeDecimal ? .decimalPad : .numberPad)
            .onReceive(Just(text)) { newValue in
                var numbers = "01234567890"
                let decimalSeparator = Locale.current.decimalSeparator ?? "."
                if includeDecimal || isCurrency {
                    numbers += decimalSeparator
                    if isCurrency {
                        numbers += String(describing: getSymbol())
                    }
                }
                if newValue.components(separatedBy: decimalSeparator).count-1 > 1 {
                    let filtered = newValue
                    self.text = String(filtered.dropLast())
                } else {
                    var filtered = newValue.filter { numbers.contains($0) }
                    if filtered != newValue {
                        self.text = filtered
                    }
                    
                    if isCurrency &&
                        !filtered.hasPrefix(getSymbol()) &&
                        filtered.filter({ $0 != Character(getSymbol()) }).count > 0 {
                        if filtered.contains(getSymbol()) {
                            filtered = filtered.replacingOccurrences(of: getSymbol(), with: "") }
                        self.text = getSymbol() + filtered
                    }
                }
            }
    }
    
    func getSymbol() -> String {
        let locale = Locale.current
        return locale.currencySymbol ?? "$"
    }
}

extension View {
    func numbersOnly(_ text: Binding<String>, includeDecimal: Bool = false, isCurrency: Bool = false) -> some View {
        self.modifier(NumberOnlyViewModifier(text: text, isCurrency: isCurrency, includeDecimal: includeDecimal))
    }
}
