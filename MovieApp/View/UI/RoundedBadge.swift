//
//  RoundedBadge.swift
//

import SwiftUI

public struct RoundedBadge : View {
    public let text: String
    public let color: Color
    
    public init(text: String, color: Color = .steam_tint) {
        self.text = text
        self.color = color
    }
    
    public var body: some View {
        HStack {
            Text(text.capitalized)
                .font(.oswald(style: .headline, weight: .light))
                .foregroundColor(.steam_foreground)
                .padding(.leading, 10)
                .padding([.top, .bottom], 5)
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 5, height: 13)
                .foregroundColor(.primary)
                .padding(.trailing, 10)
                .padding([.top, .bottom], 5)
            
            }
            .background(
                Rectangle()
                    .foregroundColor(color)
                    .cornerRadius(12)
        )
        .padding(.bottom, 4)
    }
}

#if DEBUG
struct RoundedBadge_Previews : PreviewProvider {
    static var previews: some View {
        RoundedBadge(text: "Test", color: .steam_gold)
    }
}
#endif
