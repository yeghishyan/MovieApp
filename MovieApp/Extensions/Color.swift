//
//  Color.swift
//

import Foundation
import SwiftUI

extension Color {
    public static var steam_white: Color {
        Color("steam_white", bundle: nil)
    }
    
    public static var steam_gold: Color {
        Color("steam_gold", bundle: nil)
    }
    
    public static var steam_tint: Color {
        Color("steam_tint", bundle: nil)
    }
    
    public static var steam_foreground: Color {
        Color("steam_foreground", bundle: nil)
    }
    
    public static var steam_background: Color {
        Color("steam_background", bundle: nil)
    }
    
    public static var steam_theme: Color {
        Color("steam_theme", bundle: nil)
    }
}

extension Color {
    private func makeColor(componentDelta: CGFloat) -> Color {
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        var alpha: CGFloat = 0
        
        
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return Color(
            red: add(componentDelta, toComponent: red),
            green: add(componentDelta, toComponent: green),
            blue: add(componentDelta, toComponent: blue)
        )
    }
    
    private func add(_ value: CGFloat, toComponent: CGFloat) -> CGFloat {
        return max(0, min(1, toComponent + value))
    }
    
    func lighter(componentDelta: CGFloat = 0.1) -> Color {
        return makeColor(componentDelta: componentDelta)
    }
    
    func darker(componentDelta: CGFloat = 0.1) -> Color {
        return makeColor(componentDelta: -1*componentDelta)
    }
}
