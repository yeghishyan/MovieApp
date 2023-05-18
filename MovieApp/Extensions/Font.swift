//
//  Font.swift
//

import SwiftUI

extension Font {
    public static func oswald(style: UIFont.TextStyle = .body, weight: Font.Weight = .regular) -> Font {
        var font = "Oswald-Regular"
        switch weight {
        case .heavy:    font = "Oswald-Heavy"
        case .bold:     font = "Oswald-Bold"
        case .semibold: font = "Oswald-Semibold"
        case .regular:  font = "Oswald-Regular"
        case .medium:   font = "Oswald-Medium"
        case .light:    font = "Oswald-Light"
        default: break
        }
        
        var size: CGFloat = 17.0
        switch style {
        case .largeTitle:   size = 34.0
        case .title1:       size = 28.0
        case .title2:       size = 22.0
        case .title3:       size = 20.0
        case .headline:     size = 17.0
        case .callout:      size = 16.0
        case .subheadline:  size = 15.0
        case .body:         size = 17.0
        case .footnote:     size = 13.0
        case .caption1:     size = 12.0
        case .caption2:     size = 11.0
        default: break
        }
        
        return Font.custom(font, size: size)
    }
    
    public static func oswald(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        var font = "Oswald-Regular"
        switch weight {
        case .heavy: font = "Oswald-Heavy"
        case .bold: font = "Oswald-Bold"
        case .semibold: font = "Oswald-Semibold"
        case .regular: font = "Oswald-Regular"
        case .medium: font = "Oswald-Medium"
        case .light: font = "Oswald-Light"
        default: break
        }
        return Font.custom(font, size: size)
    }
}
