//
//  MovieCardView.swift
//

import SwiftUI

struct MovieCardView: View {
    @StateObject private var movieDetailModel = MovieDetailViewModel()
    private let movieId: Int
    private let size: ImageStyle.Size

    init(movieId: Int, size: ImageStyle.Size = .custom(150)) {
        self.movieId = movieId
        self.size = size
    }
    
    private func movieDetails(movie: Movie) -> some View {
        VStack(alignment: .center, spacing: 10) {
            HStack {
                if let genres = movie.genres, !genres.isEmpty {
                    Text(genres[0].name)
                }
                Label(movie.durationHours, systemImage: "clock")
                    .imageScale(.small)
            }
        }
        .font(.oswald(size: 13))
        .textCase(.uppercase)
        .lineLimit(1)
        .foregroundColor(.primary)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private func movieImage(movie: Movie) -> some View {
        MovieImageView(imagePath: movie.poster_path, size: size, isPoster: true)

    }
    
    var body: some View {
        VStack {
            if let movie = movieDetailModel.movie {
                movieImage(movie: movie)
                movieDetails(movie: movie)
            }
        }
        .task {
            Task {
                await movieDetailModel.loadMovieDetails(id: movieId, invalidateCache: false)
            }
        }
    }
}


#if DEBUG
struct MovieCard_Preview: PreviewProvider {
    static var previews: some View {
        MovieCardView(movieId: Movie.stubbedMovies[3].id)
    }
}
#endif
