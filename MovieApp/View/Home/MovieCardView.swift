//
//  MovieCardView.swift
//

import SwiftUI

struct MovieCardView: View {
    @StateObject private var movieDetailModel = MovieDetailViewModel()
    private let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }
    
    private func genreSection(movie: Movie) -> some View {
        ZStack {
            if let genres = movie.genres, !genres.isEmpty {
                    NavigationLink(
                        destination: MovieDiscoverView(
                            title: genres[0].name,
                            param: .genre,
                            value: "\(genres[0].id)"
                        )
                    ) {
                        Text(genres[0].name)
                    }
            }
        }
    }
    
    private var glassMorphicField: some View {
        ZStack {
            GlassMorphicView(effect: .systemUltraThinMaterialDark) { view in
                view.saturationAmount = 30
                view.gaussianBlurValue = 20
            }
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [.steam_gold.opacity(0.25),
                                 .steam_foreground.opacity(0.45)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing),
                    lineWidth: 5)
        }
    }
    
    var body: some View {
        ZStack {
            if let movie = movieDetailModel.movie {
                MovieImageView(imagePath: movie.poster_path, size: .custom(300))
                    .cornerRadius(30)
                    glassMorphicField
                    .overlay {
                        VStack(alignment: .center, spacing: 15) {
                            Text(movie.userTitle)
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.oswald(size: 30, weight: .bold))
                                .blendMode(.overlay)
                            
                            MovieImageView(imagePath: movie.backdrop_path, size: .custom(250), isPoster: false)
                                .shadow(radius: 10, x: 0, y: 10)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    genreSection(movie: movie)
                                    Label(movie.durationHours, systemImage: "clock")
                                        .imageScale(.small)
                                }
                                .textCase(.uppercase)
                                
                                Text(movie.overview)
                                    .font(.oswald(size: 15, weight: .medium))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(4)
                            }
                            .padding(.horizontal, 10)
                            //Spacer()
                        }
                        .foregroundColor(.steam_theme)
                        .font(.oswald(size: 15, weight: .semibold))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 20)
                    }
                    .font(.oswald())
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
