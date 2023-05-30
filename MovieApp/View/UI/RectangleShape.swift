//
//  RectangleShape.swift
//

import SwiftUI

struct CustomRectShape: Shape {
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            let startX: CGFloat = 10
            let startY: CGFloat = 10
            
            let offset: CGFloat = 20
            
            let width = rect.size.width - 10
            let height = rect.size.height - 10
            
            
            path.addRoundedRect(
                in: CGRect(
                    origin: CGPoint(x: startX, y: startY),
                    size: CGSize(width: offset, height: height-4*startY)),
                cornerSize: CGSize(width: 30, height: 30)
            )
            
            path.addRoundedRect(
                in: CGRect(
                    origin: CGPoint(x: width-2*startX, y: startY),
                    size: CGSize(width: offset, height: height-4*startY)),
                cornerSize: CGSize(width: 30, height: 30)
            )
            
            path.addRoundedRect(
                in: CGRect(
                    origin: CGPoint(x: startX, y: startY),
                    size: CGSize(width: width-startX, height: offset)),
                cornerSize: CGSize(width: 30, height: 30)
            )
            
            path.addRoundedRect(
                in: CGRect(
                    origin: CGPoint(x: startX, y: 3*height/4),
                    size: CGSize(width: width-startX, height: height/4-startY)),
                cornerSize: CGSize(width: 30, height: 30)
            )
            
            path.closeSubpath()
        }
        //.rotation(Angle(degrees: 180))
    }//.ignoresSafeArea()
}


#if DEBUG
struct RectShape_Preview: PreviewProvider {
    static var previews: some View {
        CustomRectShape()
    }
}
#endif
