//
//  MainViewBuilder.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 10/31/23.
//

import SwiftUI

struct MainViewBuilder<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    var body: some View {
        ZStack {
            content
        }
        // apply global view mods here
    }
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

#Preview {
    MainViewBuilder(content: {
        SplashScreenView()
    })
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
