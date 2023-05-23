//
//  MovieGenreView.swift
//

import SwiftUI

struct MovieGenreListView: View {
    @StateObject private var movieGenreModel = MovieGenreViewModel()
    @Environment(\.dismiss) private var dismiss
    
    private let genre: MovieGenre
    
    init(genre: MovieGenre) {
        self.genre = genre
    }
    
    var body: some View {
        HStack {
            if let movies = movieGenreModel.movies {
                MovieListView(movies: movies)
            }
        }
        .task { loadGenres() }
        .overlay(DataLoadingView(
            phase: movieGenreModel.phase,
            retryAction: loadGenres)
        )
        .listStyle(.plain)
        .task { loadGenres() }
        .navigationTitle(genre.name)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBackButton(dismiss: dismiss)
            }
        }
    }
    
    private func loadGenres() {
        Task { await movieGenreModel.loadGenres(genre: genre) }
    }
}

#if DEBUG
struct MovieGenreView_Previews: PreviewProvider {
    static var previews: some View {
        MovieGenreListView(genre: Movie.stubbedMovies[0].genres?.first ?? MovieGenre(id: 27, name: "Horror"))
    }
}
#endif
