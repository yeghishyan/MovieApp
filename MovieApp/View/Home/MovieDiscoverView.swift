//
//  MovieDiscoverView.swift
//

import SwiftUI

struct MovieDiscoverView: View {
    @StateObject private var movieDiscoverModel = MovieDiscoverViewModel()
    @Environment(\.dismiss) private var dismiss
    
    private let title: String
    private let param: MovieDiscoverViewModel.DiscoverParam
    private let value: String
    
    init(title: String, param: MovieDiscoverViewModel.DiscoverParam, value: String) {
        self.title = title
        self.param = param
        self.value = value
    }
    
    var body: some View {
        HStack {
            if let movies = movieDiscoverModel.movies {
                MovieListView(movies: movies)
            }
        }
        .task { loadMovies() }
        .overlay(DataLoadingView(
            phase: movieDiscoverModel.phase,
            retryAction: loadMovies)
        )
        .listStyle(.plain)
        .task { loadMovies() }
        .navigationTitle(title)
        .toolbar(.visible, for: .tabBar)
    }
    
    private func loadMovies() {
        Task { await movieDiscoverModel.loadMovies(param: param, value: value) }
    }
}

#if DEBUG
struct MovieGenre_Previews: PreviewProvider {
    static var previews: some View {
        //MovieDiscoverView(param: .genre, value: "27")
        MovieDiscoverView(title: "Cris Prat", param: .people, value: "73457")
    }
}
#endif
