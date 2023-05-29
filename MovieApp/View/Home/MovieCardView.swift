//
//  MovieCardView.swift
//

import SwiftUI

struct MovieCardView: View {
    @StateObject private var movieDetailModel = MovieDetailViewModel()
    private let movieId: Int

    init(movieId: Int, quality: ImageLoader.Quality = .sd) {
        self.movieId = movieId
    }
    
    @ViewBuilder
    private func genreSection(movie: Movie) -> some View {
        if let genres = movie.genres, !genres.isEmpty {
        HStack(alignment: .center, spacing: 10) {
                LazyHStack(alignment: .center) {
                    ForEach(genres.prefix(3)) { genre in
                        NavigationLink(
                            destination: MovieDiscoverView(
                                title: genre.name,
                                param: .genre,
                                value: "\(genre.id)"
                            )
                        ) {
                            RoundedBadge(text: genre.name)
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            if let movie = movieDetailModel.movie {
                VStack(alignment:.center, spacing: 0) {
                    MovieImageView(imagePath: movie.poster_path)
                    
                    Button(action: {}, label: {
                        HStack(spacing: 2) {
                            Image(systemName: "clock")
                                .imageScale(.small)
                            Text(movie.durationText)
                        }
                        .padding(.horizontal, 5)
                    })
                    .buttonStyle(GradientButtonStyle(colors: [.clear, .steam_foreground.opacity(0.1), .clear]))
                    
                    Text(movie.userTitle)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.oswald(style: .largeTitle, weight: .bold))
                    
                    genreSection(movie: movie)
                }
                .font(.oswald())
                .foregroundColor(.steam_foreground)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(5)
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
        MovieCardView(movieId: Movie.stubbedMovies[0].id)
    }
}
#endif
