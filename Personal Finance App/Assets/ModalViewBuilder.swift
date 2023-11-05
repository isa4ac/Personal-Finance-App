//
//  ModalViewBuilder.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 11/4/23.
//

import Foundation
import SwiftUI

struct ModalViewBuilder<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    var size: CGSize
    var body: some View {
        RoundedRectangle(cornerRadius: 20).fill(Material.ultraThin)
            .frame(width: size.width, height: size.height)
            .overlay (
                List {
                    content
                }
                .listStyle(.plain)
            )
        // apply global view mods here
    }
    
    init(size: CGSize, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.size = size
    }
}

