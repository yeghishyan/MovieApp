//
//  ImageStyle.swift
//

import SwiftUI

struct ImageStyle: ViewModifier {
    enum Size {
        case small, medium, big, huge, original
        case custom(CGFloat)
        
        func width() -> CGFloat {
            switch self {
            case .custom(let size): return size
                
            case .small: return 148
            case .medium: return 185
            case .big: return 300
            case .huge: return 500
            case .original: return 677
            }
        }
        
        func height() -> CGFloat {
            return self.width() * 3/2
        }
    }
    
    let size: Size
    
    func body(content: Content) -> some View {
        return content
            .cornerRadius(13)
            //.shadow(color: .black.opacity(0.5), radius: 8)
            .frame(width: size.width(), height: size.height())
            .scaledToFit()
    }
}

extension View {
    func fixedSize(size: ImageStyle.Size) -> some View {
        return ModifiedContent(content: self, modifier: ImageStyle(size: size))
    }
}
