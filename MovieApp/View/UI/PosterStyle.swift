//
//  PosterStyle.swift
//

import SwiftUI

struct PosterStyle: ViewModifier {
    enum Size {
        case small, medium, big
        
        func width() -> CGFloat {
            switch self {
            case .small: return 70
            case .medium: return 130
            case .big: return 240
            }
        }
        
        func height() -> CGFloat {
            return self.width() * 6/4
        }
        
    }
    
    let size: Size
    
    func body(content: Content) -> some View {
        return content
            .cornerRadius(13)
            //.shadow(color: .black.opacity(0.5), radius: 8)
            .frame(maxWidth: size.width(), maxHeight: size.height())
            .scaledToFit()
    }
}

extension View {
    func fixedSize(size: PosterStyle.Size) -> some View {
        return ModifiedContent(content: self, modifier: PosterStyle(size: size))
    }
}
