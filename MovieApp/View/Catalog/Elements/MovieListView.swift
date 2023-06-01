//
//  MovieRowView.swift
//

import SwiftUI

struct MovieListView: View {
    @EnvironmentObject private var appState: AppState

    let movies: [Movie]
    let alignment: Axis.Set
    
    init(movies: [Movie], alignment: Axis.Set  = .vertical) {
        self.movies = movies
        self.alignment = alignment
    }
    
    var body: some View {
        ZStack {
            if alignment == .vertical {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(self.movies) { movie in
                            NavigationLink(
                                destination: MovieDetailView(movieId: movie.id)
                            ) {
                                if movie.poster_path != nil {
                                    MovieCellView(movie: movie)
                                }
                            }
                        }
                    }
                }
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 10) {
                        ForEach(self.movies) { movie in
                            NavigationLink(
                                destination: MovieDetailView(movieId: movie.id)
                            ) {
                                MoviePoster(movie: movie)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        
        //.toolbar(.hidden, for: .tabBar)
        //.toolbar(.automatic, for: .bottomBar)
    }
}

#if DEBUG
struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movies: Movie.stubbedMovies)
            .environmentObject(sampleState)
        MovieListView(movies: Movie.stubbedMovies, alignment: .horizontal)
            .environmentObject(sampleState)
    }
}
#endif
