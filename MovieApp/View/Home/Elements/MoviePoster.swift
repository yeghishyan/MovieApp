//
//  MoviePoster.swift
//

import SwiftUI

struct MoviePoster: View {
    @ObservedObject var imageLoader: ImageLoader
    let size: PosterStyle.Size
    let movie: Movie

    init(movie: Movie, quality: ImageService.Quality = .sd, size: PosterStyle.Size = .medium) {
        self.movie = movie
        self.size = size
        self.imageLoader = ImageLoaderCache.shared.loaderFor(path: movie.poster_path, quality: quality)
        //ImageLoader(path: movie.poster_path, quality: quality)
    }
    
    private var image: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Rectangle()
                    .frame(width: size.width(), height: size.height())
                    .foregroundColor(.gray)
            }
        }.fixedSize(size: size)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            image
                .overlay(alignment: .topTrailing, content: {
                    CircleRating(score: Int(movie.vote_average * 10), size: size.width()/4)
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
