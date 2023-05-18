//
//  MovieDetailView.swift
//

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    let movieTitle: String
    @StateObject private var movieDetailState = MovieDetailViewModel()
    @State private var selectedTrailerURL: URL?
    
    var body: some View {
        List {
            if let movie = movieDetailState.movie {
                MovieDetailImage(imagePath: movie.backdrop_path)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                MovieDetailListView(movie: movie) //, selectedTrailerURL: $selectedTrailerURL)
            }
        }
        .listStyle(.plain)
        .task { loadMovie() }
        .overlay(DataLoadingView(
            phase: movieDetailState.phase,
            retryAction: loadMovie)
        )
//        .sheet(item: $selectedTrailerURL) { SafariView(url: $0).edgesIgnoringSafeArea(.bottom)}
        .navigationTitle(movieTitle)
    }
    
    //@Sendable
    private func loadMovie() {
        Task { await movieDetailState.loadMovie(id: self.movieId) }
    }
}

struct MovieDetailImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imagePath: String
    
    var body: some View {
        ZStack {
            //Color.gray.opacity(0.3)
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear { imageLoader.loadImage(with: imagePath) }
    }
}

#if DEBUG
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieId: Movie.stubbedMovie.id, movieTitle: Movie.stubbedMovie.title)
    }
}
#endif
