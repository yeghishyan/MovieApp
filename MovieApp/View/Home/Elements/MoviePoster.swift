//
//  MoviePoster.swift
//

import SwiftUI

struct MoviePoster: View {
    let movie: Movie
    @ObservedObject var imageLoader: ImageLoader
    @State var scale = 1.0

    init(movie: Movie, scale: Double = 1.0) {
        self.movie = movie
        self.imageLoader = ImageLoader(path: movie.poster_path, size: .sd)
        self.scale = scale
    }
    
    private var image: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Rectangle()
                    .foregroundColor(.gray)
            }
        }.fixedSize(size: .small)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            image
                .overlay(alignment: .topTrailing, content: {
                    CircleRating(score: Int(movie.vote_average * 10), size: 30)
                        .padding([.trailing, .top], 10)
                })
        }
        //.contextMenu{MovieContextMenu(movieId: self.movieId) }
    }
}

#if DEBUG
struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MoviePoster(movie: Movie.stubbedMovies[0])
        }
    }
}
#endif
