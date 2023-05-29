//
//  MoviePoster.swift
//

import SwiftUI

struct MoviePoster: View {
    @ObservedObject private var imageLoader: ImageLoader
    private let size: ImageStyle.Size
    private let movie: Movie

    init(movie: Movie, quality: ImageLoader.Quality = .sd, size: ImageStyle.Size = .small) {
        self.movie = movie
        self.size = size
        self.imageLoader = ImageLoader(path: movie.poster_path, quality: quality)
    }
    
    private var image: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .transition(.opacity.animation(Animation.default.speed(0.5)))
            } else {
                Rectangle()
                    .fill(.gray)
                    .shimmering()
            }
        }
        .onAppear {
            self.imageLoader.loadImage()
        }
        .fixedSize(size: size)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            image
                .overlay(alignment: .topTrailing, content: {
                    CircleRating(score: Int(movie.vote_average * 10), size: size.width()/4)
                        .redacted(reason: imageLoader.image == nil ? .placeholder : [])
                        .shimmering(active: imageLoader.image == nil)
                        .padding(.trailing, 15)
                        .padding(.top, 10)
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
