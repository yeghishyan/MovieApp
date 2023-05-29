//
//  LoadingFiveLinesChronological.swift
//
//  Created by Nick Sarno on 1/12/21.
//  https://github.com/SwiftfulThinking/SwiftfulLoadingIndicators/tree/main
//

import SwiftUI
import Combine

struct LoadingFiveLinesChronological: View {
    @State var isAnimating: Bool = true
    let timing: Double
    
    let maxCounter: Int = 7
    
    let frame: CGSize
    let primaryColor: Color
    
    init(color: Color = .black, size: CGFloat = 50, speed: Double = 0.30) {
        timing = speed
        frame = CGSize(width: size*2, height: size)
        primaryColor = color
    }

    var body: some View {
        HStack(spacing: frame.width / 15) {
            ForEach(0..<maxCounter, id: \.self) { index in
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(primaryColor)
                    .frame(maxHeight: isAnimating ? frame.height / 5 : .infinity)
                    .animation(
                        Animation
                            .easeOut(duration: timing / 2)
                            .delay(timing)
                            .repeatForever(autoreverses: true)
                            .delay(timing / Double(maxCounter) * Double(index + 1))
                        , value: isAnimating
                    )
            }
        }
        .frame(width: frame.width, height: frame.height, alignment: .center)
        .onAppear {
            isAnimating.toggle()
        }
    }
}


#if DEBUG
struct LoadingFiveLinesChronological_Previews: PreviewProvider {
    static var previews: some View {
        LoadingFiveLinesChronological()
    }
}
#endif
