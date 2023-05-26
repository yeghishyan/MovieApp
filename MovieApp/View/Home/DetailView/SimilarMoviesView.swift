//
//  SimilarMoviesView.swift
//

import SwiftUI

struct SimilarMoviesView: View {
    @StateObject private var similarMoviesModel = SimilarMoviesViewModel()
    let movie: Movie
    
    var body: some View {
        VStack {
            if !similarMoviesModel.movies.isEmpty {
                VStack(alignment: .leading) {
                    Text("Similar movies")
                        .font(.oswald(size: 15)).bold()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .top, spacing: 10) {
                            ForEach(similarMoviesModel.movies) { movie in
                                NavigationLink(
                                    destination: MovieDetailView(movie: movie)
                                ) {
                                    VStack {
                                        MoviePoster(movie: movie, quality: .ld, size: .small)
                                        Text(movie.title)
                                            .frame(maxWidth: 70)
                                            .font(.oswald(size: 13))
                                            .foregroundColor(.primary)
                                            .lineLimit(1).truncationMode(.tail)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .task {
            Task { await similarMoviesModel.fetchSimilarMovies(movieId: movie.id) }
        }
        .overlay {
            DataLoadingView(
                phase: similarMoviesModel.phase,
                retryAction: {})
        }
    }
}
