//
//  GlassMorphicStyle.swift
//  MovieApp
//
//  Created by valod on 31.05.23.
//

import SwiftUI

struct GlassMorphicStyle: ViewModifier {
    let cornerRadius: CGFloat
    let lineWidth: CGFloat
    let saturation: CGFloat
    let blur: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    GlassMorphicView(effect: .systemUltraThinMaterial) { view in
                        view.saturationAmount = saturation
                        view.gaussianBlurValue = blur
                    }
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                    
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [.steam_foreground.opacity(0.15),
                                         .steam_foreground.opacity(0.3)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing),
                            lineWidth: lineWidth)
                }
            }
    }
}

extension View {
    func glassmorpism(
        radius: CGFloat = 0,
        lineWidth: CGFloat = 1,
        saturation: CGFloat = 15,
        blur: CGFloat = 4
    ) -> some View {
        modifier(GlassMorphicStyle(
            cornerRadius: radius,
            lineWidth: lineWidth,
            saturation: saturation,
            blur: blur
        ))
    }
}

struct GlassMorphicStyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                LinearGradient(
                    colors: [.steam_background,
                             .steam_background.opacity(0.99)
                    ],
                    startPoint: .bottom,
                    endPoint: .top
                )
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 200, height: 200)
                    .offset(x: -190)
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 140, height: 140)
                    .offset(x: 190, y: -400)
            }
            .shadow(color: .steam_foreground.opacity(0.3), radius: 5, y: 5)

            ScrollView {
                PrimaryButton(title: "LOGIN")
                    .frame(height: 400)
                    .glassmorpism()
                    .padding()
                    .offset(y: 100)
            }
        }
        .ignoresSafeArea()
    }
}
