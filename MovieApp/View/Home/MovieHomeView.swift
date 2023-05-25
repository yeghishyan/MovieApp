//
//  HomeView.swift
//

import SwiftUI
import Combine

struct MovieHomeView: View {
    @StateObject private var searchModel = MovieSearchViewModel()
    @StateObject private var movieHomeModel = MovieHomeViewModel()
    @State private var selectedSection: Int = 0
    
    var body: some View {
        //TabView(selection: $selectedSection) {
        VStack {
            NavigationStack {
                if !movieHomeModel.sections.isEmpty {
                    SearchableView(selected: $selectedSection)
                        .environmentObject(searchModel)
                        .environmentObject(movieHomeModel)
                }
            }
            .searchable(text: $searchModel.searchText)
            .onReceive(searchModel.$searchText.debounce(for: 0.4, scheduler: RunLoop.main)) { _ in
                print(searchModel.searchText)
                if !searchModel.searchText.isEmpty {
                    searchMovies()
                }
            }
        }
        .task { loadMovies(invalidateCache: false) }
        .refreshable { loadMovies(invalidateCache: true) }
        .overlay(DataLoadingView(
            phase: movieHomeModel.phase,
            retryAction: { loadMovies(invalidateCache: true) })
        )
    }
    
    private func loadMovies(invalidateCache: Bool) {
        Task { await movieHomeModel.loadMoviesFromAllEndpoints(invalidateCache: invalidateCache) }
    }
    
    private func searchMovies() {
        Task { await searchModel.loadSearchResult() }
    }
}

struct SearchableView: View {
    @EnvironmentObject private var searchModel: MovieSearchViewModel
    @EnvironmentObject private var movieHomeModel: MovieHomeViewModel
    @State private var listViewMode: Bool = true

    @Environment(\.isSearching) private var isSearching
    @Binding private var selectedSection: Int
    
    init(selected: Binding<Int>) {
        self._selectedSection = selected
    }
    
    private var viewModeButton: some View {
        Button(action: {
            self.listViewMode.toggle()
        }) {
            Image(systemName: listViewMode ? "circle.grid.3x3.circle": "line.3.horizontal.circle")
                .resizable().imageScale(.large)
                .frame(width: 25, height: 25, alignment: .center)
        }
        .frame(width: 44, height: 44, alignment: .center)
        .tint(Color.steam_foreground)
    }
    
    private func moviesRow(section: MovieSection) -> some View{
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(section.title)
                    .font(.oswald(size: 23))
                
                NavigationLink(destination: MovieListView(movies: section.movies)
                    .navigationBarTitle(section.title), label: {
                        Spacer()
                        Text("See all")
                        Image(systemName: "chevron.right")
                    })
            }
            .padding(.horizontal, 10)
            .font(.oswald(size: 15))
            .foregroundColor(.steam_foreground)
            
            Grid {
                GridRow {
                    MovieListView(movies: Array<Movie>(section.movies.prefix(5)), alignment: .horizontal)
                        .padding(.top, -10)
                        .padding(.bottom, 8)
                }
                
                GridRow {
                    MovieListView(movies: Array<Movie>(section.movies.suffix(5)), alignment: .horizontal)
                        .padding(.top, -10)
                        .padding(.bottom, 8)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            if isSearching {
                MovieListView(movies: searchModel.movies)
            }
            else if !movieHomeModel.sections.isEmpty {
                if listViewMode {
                    MovieListView(movies: movieHomeModel.sections[selectedSection].movies, alignment: .vertical)
                        .navigationTitle(movieHomeModel.sections[selectedSection].title)
                }
                else {
                    ScrollView(showsIndicators: false) {
                        ForEach(movieHomeModel.sections, id: \.self) { section in
                            moviesRow(section: section)
                                .navigationTitle(movieHomeModel.sections[selectedSection].title)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) { viewModeButton }
        }
    }
}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
        //TabView {
        MovieHomeView()
        //}
    }
}
#endif
