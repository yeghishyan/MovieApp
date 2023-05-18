//
//  PosterStyle.swift
//

import SwiftUI

struct PosterStyle: ViewModifier {
    enum Size {
        case small, medium, big
        
        func width() -> CGFloat {
            switch self {
            case .small: return 100
            case .medium: return 153
            case .big: return 250
            }
        }
        func height() -> CGFloat {
            switch self {
            case .small: return 150
            case .medium: return 230
            case .big: return 375
            }
        }
    }
    
    let size: Size
    
    func body(content: Content) -> some View {
        return content
            .frame(width: size.width(), height: size.height())
            .cornerRadius(5)
            .shadow(radius: 8)
    }
}

extension View {
    func posterStyle(size: PosterStyle.Size) -> some View {
        return ModifiedContent(content: self, modifier: PosterStyle(size: size))
    }
}
