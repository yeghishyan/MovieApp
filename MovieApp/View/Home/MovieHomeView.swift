//
//  HomeView.swift
//

import SwiftUI
import Combine

struct MovieHomeView: View {
    @StateObject private var searchModel = MovieSearchViewModel()
    @Environment(\.isSearching) private var isSearching
    
    var body: some View {
        NavigationStack {
            SearchableView()
                .environmentObject(searchModel)
        }
        .searchable(text: $searchModel.searchText)
        .onReceive(searchModel.$searchText.debounce(for: 0.3, scheduler: RunLoop.main)) { _ in
            print(searchModel.searchText)
            if !searchModel.searchText.isEmpty {
                searchMovies()
            }
        }
    }
    
    private func searchMovies() {
        Task { await searchModel.loadSearchResult() }
    }
}

struct SearchableView: View {
    @EnvironmentObject private var searchModel: MovieSearchViewModel
    @Environment(\.isSearching) var isSearching
    
    @StateObject private var movieHomeModel = MovieHomeViewModel()
    @State private var selectedSection: Int = 0
    
    var body: some View {
        if isSearching {
            MovieListView(movies: searchModel.movies)
        }
        else {
            ZStack {
                ForEach(movieHomeModel.sections.prefix(1).indices, id: \.self) { id in
                    MovieListView(movies: movieHomeModel.sections[id].movies, alignment: .vertical)
                        .tag(id)
                    .navigationTitle(movieHomeModel.sections[id].title)
                }
            }
            .task { loadMovies(invalidateCache: false) }
            //.refreshable { loadMovies(invalidateCache: true) }
            .overlay(DataLoadingView(
                phase: movieHomeModel.phase,
                retryAction: { loadMovies(invalidateCache: true) })
            )
            .tabViewStyle(.page)
            .padding(.horizontal, 10)
        }
    }
    
    
    private func loadMovies(invalidateCache: Bool) {
        Task { await movieHomeModel.loadMoviesFromAllEndpoints(invalidateCache: invalidateCache) }
    }
    
}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}
#endif
