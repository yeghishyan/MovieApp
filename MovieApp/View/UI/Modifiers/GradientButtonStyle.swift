//
//  GradientButtonStyle.swift
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    var colors: [Color] = [Color.red, Color.orange]
    var cornerRadius: CGFloat = 12
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.steam_foreground)
            .padding(.vertical, 0)
            .padding(.horizontal, 10)
            .background(LinearGradient(
                gradient: Gradient(colors: colors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .cornerRadius(cornerRadius)
            .buttonBorderShape(.capsule)
            .font(.oswald(size: 16, weight: .medium))
            .lineLimit(1)
            //.kerning(-0.9)
    }
}
