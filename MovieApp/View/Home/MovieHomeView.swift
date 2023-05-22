//
//  HomeView.swift
//

import SwiftUI
import Combine

struct MovieHomeView: View {
    @StateObject private var movieHomeState = MovieHomeViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(movieHomeState.sections, id: \.self) { section in
                VStack(alignment: .leading, spacing: 5) {
                    Text(section.title)
                        .font(.oswald(style: .largeTitle, weight: .medium))
                    if case .nowPlaying = section.endpoint {
                        MovieListView(title: section.title, movies: section.movies, alignment: .horizontal)
                    }
                    else {
                        MovieListView(title: section.title, movies: section.movies)
                    }
                }
            }
        }
        .padding(.horizontal)
        .task { loadMovies(invalidateCache: false) }
        .refreshable { loadMovies(invalidateCache: true) }
        .overlay(DataLoadingView(
            phase: movieHomeState.phase,
            retryAction: { loadMovies(invalidateCache: true) })
        )
        .navigationTitle("XCA Movies")
    }
    
    //@Sendable
    private func loadMovies(invalidateCache: Bool) {
        Task { await movieHomeState.loadMoviesFromAllEndpoints(invalidateCache: invalidateCache) }
    }
}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}
#endif
