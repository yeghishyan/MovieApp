//
//  MovieRowView.swift
//

import SwiftUI

struct MovieListView: View {
    let title: String
    let movies: [Movie]
    let alignment: Axis.Set
    
    init(title: String, movies: [Movie], alignment: Axis.Set  = .vertical) {
        self.title = title
        self.movies = movies
        self.alignment = alignment
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                if alignment == .vertical {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(self.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieCellView(movie: movie)
                            }
                        }
                    }
                } else {
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
        MovieListView(title: "Test", movies: Movie.stubbedMovies)
            .frame(width: UIScreen.main.bounds.width)
            .frame(height: UIScreen.main.bounds.height - 100)
    }
}
#endif
