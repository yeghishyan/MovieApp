//
//  MovieDiscoverView.swift
//

import SwiftUI

struct MovieDiscoverView: View {
    @StateObject private var movieDiscoverModel = MovieDiscoverViewModel()
    //@Binding private var selectedTab: TabbarView.Tab
    
    private let title: String
    private let param: MovieDiscoverViewModel.DiscoverParam
    private let value: String
    
    init(title: String, param: MovieDiscoverViewModel.DiscoverParam, value: String) {//, selectedTab: Binding<TabbarView.Tab>) {
        self.title = title
        self.param = param
        self.value = value
        //self._selectedTab = selectedTab
    }
    
    var body: some View {
        HStack {
            MovieListView(movies: movieDiscoverModel.movies)
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
struct MovieDiscover_Previews: PreviewProvider {
    static var previews: some View {
        //MovieDiscoverView(param: .genre, value: "27")
        MovieDiscoverView(title: "Cris Prat", param: .people, value: "73457")
            .environmentObject(sampleState)
    }
}
#endif
