//
//  MovieRowView.swift
//

import SwiftUI

struct MovieRowView: View {
    let title: String
    let movies: [Movie]
    let alignment: Axis.Set
    
    init(title: String, movies: [Movie], alignment: Axis.Set  = .vertical) {
        self.title = title
        self.movies = movies
        self.alignment = alignment
    }
    
    var body: some View {
        VStack {
            if alignment == .vertical {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(self.movies) { movie in
                            NavigationLink(
                                destination: MovieDetailView(movieId: movie.id, movieTitle: movie.title)) {
                                    MovieCellView(movie: movie)
                                }
                        }
                    }
                }
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 10) {
                        ForEach(self.movies) { movie in
                            NavigationLink(
                                destination: MovieDetailView(movieId: movie.id, movieTitle: movie.title)) {
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
        MovieRowView(title: "Test", movies: Movie.stubbedMovies)
            .frame(width: UIScreen.main.bounds.width)
            .frame(height: UIScreen.main.bounds.height - 100)
    }
}
#endif
