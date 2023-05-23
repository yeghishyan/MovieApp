//
//  RoundedBadge.swift
//

import SwiftUI

public struct RoundedBadge : View {
    let text: String
    let color: Color
    let image: Image?
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    
    init(text: String,
         color: Color = .steam_gold,
         image: Image? = nil,
         horizontalPadding: CGFloat = 10,
         verticalPadding: CGFloat = 0
    ) {
        self.text = text
        self.color = color
        self.image = image
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if let image = image {
                image
                    .scaledToFit()
                    .foregroundColor(.primary)
                    .padding(.leading, 3)
            }
            Text(text)
                .font(.oswald(size: 15, weight: .medium))
                .foregroundColor(.steam_foreground.darker())
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)
                .kerning(-0.5)
                .lineLimit(1)
        }
        .background(Rectangle()
            .foregroundColor(color)
            .cornerRadius(15)
        )
    }
}

#if DEBUG
struct RoundedBadge_Previews : PreviewProvider {
    static var previews: some View {
        RoundedBadge(
            text: "Test",
            color: .steam_gold,
            image: Image(systemName: "star")
        )
    }
}
#endif
