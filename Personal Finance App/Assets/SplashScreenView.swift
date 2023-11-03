//
//  MainLoadingView.swift
//  Personal Finance App
//
//  Created by Isaac Vanmeter on 10/31/23.
//

import SwiftUI

struct SplashScreenView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var isActive = false
    @State private var size = 0.8
    @State private var progress: CGFloat = 0
    let gradient1 = Gradient(colors: [Color(hex: 0x71c971, alpha: 0.0), Color(hex: 0x85c797, alpha: 0.0), .green])
    let gradient2 = Gradient(colors: [ Color(hex: 0x85c797, alpha: 0.0), .green, Color(hex: 0x71c971, alpha: 0.0)])
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            MainViewBuilder {
                Rectangle()
                    .animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress)
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: true)) {
                            self.progress = 1
                        }
                    }
                    .mask(
                        VStack(spacing: 0) {
                            Text("Networthy")
                                .font(.largeTitle)
                                .bold()
                            Text("A personal finance app")
                            Text("by Isaac Van Meter")
                                .font(.footnote)
                        }
                            .scaleEffect(size)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 0.8)) {
                                    self.size = 1.2
                                }
                            }
                    )
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.isActive = true
                }
            }
        }
    }
}

extension View {
    func animatableGradient(fromGradient: Gradient, toGradient: Gradient, progress: CGFloat) -> some View {
        self.modifier(AnimatableGradientModifier(fromGradient: fromGradient, toGradient: toGradient, progress: progress))
    }
}

struct AnimatableGradientModifier: AnimatableModifier {
    let fromGradient: Gradient
    let toGradient: Gradient
    var progress: CGFloat = 0.0
 
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
 
    func body(content: Content) -> some View {
        var gradientColors = [Color]()
 
        for i in 0..<fromGradient.stops.count {
            let fromColor = UIColor(fromGradient.stops[i].color)
            let toColor = UIColor(toGradient.stops[i].color)
 
            gradientColors.append(colorMixer(fromColor: fromColor, toColor: toColor, progress: progress))
        }
 
        return LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .bottomTrailing, endPoint: .topLeading)
    }
 
    func colorMixer(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> Color {
        guard let fromColor = fromColor.cgColor.components else { return Color(fromColor) }
        guard let toColor = toColor.cgColor.components else { return Color(toColor) }
 
        let red = fromColor[0] + (toColor[0] - fromColor[0]) * progress
        let green = fromColor[1] + (toColor[1] - fromColor[1]) * progress
        let blue = fromColor[2] + (toColor[2] - fromColor[2]) * progress
 
        return Color(red: Double(red), green: Double(green), blue: Double(blue))
    }
}

#Preview {
    SplashScreenView()
}
