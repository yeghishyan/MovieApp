//
//  PopularityBadge.swift
//

import SwiftUI

struct CircleRating : View {
    let score: Int
    let textColor: Color
    let sideSize: CGFloat
    
    @State private var isDisplayed = false
    
    public init(score: Int = 0, textColor: Color = .primary, size: CGFloat = 35) {
        self.score = score
        self.textColor = textColor
        self.sideSize = size
    }
    
    private var scoreColor: Color {
        get {
            if score < 40 {
                return Color.red.darker()
            } else if score < 60 {
                return Color.red.lighter(componentDelta: 0.2)
            } else if score < 75 {
                return .green.darker()
            }
            return .green
        }
    }
    
    private var overlay: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: isDisplayed ? CGFloat(score) / 100 : 0)
                .stroke(style: StrokeStyle(lineWidth: 5, dash: [30/sideSize]))
                .foregroundColor(scoreColor)
                .animation(Animation.interpolatingSpring(stiffness: 60, damping: 10).delay(0.19), value: score)
        }
        .rotationEffect(.degrees(-90))
        .onAppear { self.isDisplayed = true }
    }
    
    var body: some View {
        ZStack {
            Text("\(score)%")
                .kerning(-0.9)
                .font(Font.system(size: sideSize/10 + 7))
                .fontWeight(.bold)
                .foregroundColor(scoreColor)
            Circle()
                .foregroundColor(.clear)
                .frame(width: 40)
                .overlay(overlay)
                .shadow(color: scoreColor, radius: 3)
            }
        .frame(width: sideSize, height: sideSize)
    }
}

#if DEBUG
struct PopularityBadge_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
            CircleRating(score: 10)
            CircleRating(score: 30)
            CircleRating(score: 60)
            CircleRating(score: 90)
        }
    }
}
#endif
