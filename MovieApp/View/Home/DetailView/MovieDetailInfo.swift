//
//  MovieDetailInfo.swift
//

import SwiftUI

struct MovieDetailInfo: View {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    private var glassMorphicField: some View {
        ZStack{
            GlassMorphicView(effect: .systemUltraThinMaterialDark) { view in
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [.white.opacity(0.25),
                                 .white.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing),
                    lineWidth: 2)
        }
        .overlay { content }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    private var content: some View {
        ZStack {
            
        }
    }
    
    var body: some View {
        ZStack {
            glassMorphicField
        }
    }
}


#if DEBUG
struct MovieDetailInfo_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailInfo(movie: Movie.stubbedMovies[0])
    }
}
#endif
