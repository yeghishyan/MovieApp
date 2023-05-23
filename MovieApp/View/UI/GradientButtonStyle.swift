//
//  GradientButtonStyle.swift
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    var gradient = Gradient(colors: [Color.red, Color.orange])
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.steam_foreground)
            .padding(.vertical, 0)
            .padding(.horizontal, 10)
            .background(LinearGradient(
                gradient: gradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .cornerRadius(12.0)
            .buttonBorderShape(.capsule)
            .font(.oswald(size: 16, weight: .medium))
            .lineLimit(1)
            .kerning(-0.9)
    }
}
