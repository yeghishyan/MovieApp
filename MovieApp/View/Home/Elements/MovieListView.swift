//
//  MovieRowView.swift
//

import SwiftUI

struct MovieListView: View {
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
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieCellView(movie: movie)
                            }
                        }
                    }
                }
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 10) {
                        ForEach(self.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MoviePoster(movie: movie)
                            }
                        }
                    }
                }
            }
        }
    }
}

#if DEBUG
struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movies: Movie.stubbedMovies)
        MovieListView(movies: Movie.stubbedMovies, alignment: .horizontal)
    }
}
#endif
