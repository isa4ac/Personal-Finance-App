//
//  MainButton.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/1/23.
//

import SwiftUI

struct MainButton: View {
    var text: String
    var textBold = false
    var action: () -> ()
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Button {
                action()
            } label: {
                Text(text)
                    .foregroundStyle(.blue)
                    .bold(textBold)
            }
            Spacer()
        }
//        .padding()
//        .background(Color(.white))
    }
}

#Preview {
    MainButton(text: "Test", action: {})
}
