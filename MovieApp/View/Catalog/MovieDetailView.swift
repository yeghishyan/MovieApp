//
//  MovieDetailView.swift
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var movieDetailModel = MovieDetailViewModel()
    private let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            if let movie = movieDetailModel.movie {
                MovieDetailViewProxy(movie: movie, safeArea: safeArea, size: size)
                    .ignoresSafeArea(.container, edges: .all)
            }
        }
        .task { loadMovieDetails() }
        .overlay(DataLoadingView(
            phase: movieDetailModel.phase,
            retryAction: loadMovieDetails)
        )
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    private func loadMovieDetails() {
        Task {
            await movieDetailModel.loadMovieDetails(id: self.movieId)
        }
    }
}

#if DEBUG
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieId: Movie.stubbedMovies[3].id)
    }
}
#endif
