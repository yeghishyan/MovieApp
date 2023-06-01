//
//  SearchableView.swift
//

import SwiftUI

struct SearchableViewParent<Content: View>: View {
    @StateObject private var searchModel = MovieSearchViewModel()

    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack {
            SearchableView() {
                content
            }
            .environmentObject(searchModel)
        }
        .searchable(text: $searchModel.searchText)
        .onReceive(searchModel.$searchText.debounce(for: 0.4, scheduler: RunLoop.main)) { _ in
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

struct SearchableView<Content: View>: View {
    @EnvironmentObject private var searchModel: MovieSearchViewModel
    @Environment(\.isSearching) private var isSearching
    
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if isSearching {
                MovieListView(movies: searchModel.movies)
            }
            else {
                content
            }
        }
    }
}

#if DEBUG
struct SearchableView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchableViewParent() {
                MovieHomeView()
            }
        }
    }
}
#endif
