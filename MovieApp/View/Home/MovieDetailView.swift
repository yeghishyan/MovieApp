//
//  MovieDetailView.swift
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var movieDetailState = MovieDetailViewModel()
    let movie: Movie
    
    var body: some View {
        ZStack {
            if let movie = movieDetailState.movie {
                MovieDetailImage(imagePath: movie.poster_path)
                MovieDetailInfo(movie: movie)
            }
        }
        .task { loadMovie() }
        .overlay(DataLoadingView(
            phase: movieDetailState.phase,
            retryAction: loadMovie)
        )
        .navigationTitle(movie.userTitle)
    }
    
    private func loadMovie() {
        Task {
            await movieDetailState.loadMovie(id: self.movie.id)
        }
    }
}


#if DEBUG
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.stubbedMovies[0])
    }
}
#endif
