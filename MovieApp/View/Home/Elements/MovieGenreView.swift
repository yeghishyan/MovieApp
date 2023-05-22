//
//  MovieGenreView.swift
//

import SwiftUI

struct MovieGenreView: View {
    @StateObject private var movieGenreState = MovieGenreViewModel()
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        HStack {
            if let genres = movie.genre_ids {
                ForEach(genres, id: \.self) { id in
                    Text(movieGenreState.name(id: id))
                }
            }
        }
        .listStyle(.plain)
        .task { loadGenres() }
    }
    
    private func loadGenres() {
        Task { await movieGenreState.loadGenres() }
    }
}

#if DEBUG
struct MovieGenreView_Previews: PreviewProvider {
    static var previews: some View {
        MovieGenreView(movie: Movie.stubbedMovies[0])
    }
}
#endif
