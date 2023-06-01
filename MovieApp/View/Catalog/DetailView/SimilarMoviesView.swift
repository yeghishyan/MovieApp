//
//  SimilarMoviesView.swift
//

import SwiftUI

struct SimilarMoviesView: View {
    @StateObject private var similarMoviesModel = SimilarMoviesViewModel()
    @State private var isLoading: Bool = true
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
                                    destination: MovieDetailView(movieId: movie.id)
                                ) {
                                    VStack {
                                        MoviePoster(movie: movie, quality: .ld, size: .custom(130))
                                        Text(movie.userTitle)
                                            .frame(maxWidth: 70)
                                            .font(.oswald(size: 13))
                                            .foregroundColor(.primary)
                                            .lineLimit(1).truncationMode(.tail)
                                    }
                                }
                            }
                        }
                    }
                    .padding([.leading, .bottom], 5)
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .shimmering(active: isLoading)
        .task {
            Task { await similarMoviesModel.fetchSimilarMovies(movieId: movie.id) }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isLoading = false
            }
        }
    }
}

#if DEBUG
struct SimilarMovies_Preview: PreviewProvider {
    static var previews: some View {
        SimilarMoviesView(movie: Movie.stubbedMovies[0])
    }
}
#endif
