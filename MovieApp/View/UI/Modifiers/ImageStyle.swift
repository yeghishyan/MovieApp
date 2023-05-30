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
    }
    
    let size: Size
    let isPoster: Bool
    
    func body(content: Content) -> some View {
        return content
            .cornerRadius(13)
            //.shadow(color: .black.opacity(0.5), radius: 8)
            .frame(width: size.width())
            .frame(height: isPoster ? size.width()*3/2 : size.width()*9/16)
            .scaledToFit()
    }
}

extension View {
    func fixedSize(size: ImageStyle.Size, isPoster: Bool = true) -> some View {
        return ModifiedContent(content: self, modifier: ImageStyle(size: size, isPoster: isPoster))
    }
}
