//
//  ContentView.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    @State var progress: CGFloat = 0
    @State var name = String()
    var body: some View {
        // conditional logic if user has already finished setup
        SetupView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
