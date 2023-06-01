//
//  HomeView.swift
//

import SwiftUI
import Combine

struct MovieCatalogView: View {
    @StateObject private var movieCatalogModel = MovieCatalogViewModel()
    @State private var selectedSection: Int = 0
    @State private var listViewMode: Bool = true
    
    @ViewBuilder
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
    
    @ViewBuilder
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
                    MovieListView(movies: Array<Movie>(section.movies.prefix(8)), alignment: .horizontal)
                        .padding(.top, -10)
                        .padding(.bottom, 8)
                }
            }
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        ZStack {
            if !movieCatalogModel.sections.isEmpty {
                if listViewMode {
                    MovieListView(movies: movieCatalogModel.sections[selectedSection].movies, alignment: .vertical)
                        .navigationTitle(movieCatalogModel.sections[selectedSection].title)
                }
                else {
                    ScrollView(showsIndicators: false) {
                        ForEach(movieCatalogModel.sections, id: \.self) { section in
                            moviesRow(section: section)
                                .navigationTitle(movieCatalogModel.sections[selectedSection].title)
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
    
    var body: some View {
        VStack {
            NavigationStack {
                ZStack {
                    SearchableViewParent(content: {
                        content()
                    })
                }
            }
        }
        .task { loadMovies(invalidateCache: false) }
        .overlay(DataLoadingView(
            phase: movieCatalogModel.phase,
            retryAction: { loadMovies(invalidateCache: true) })
        )
    }
    
    private func loadMovies(invalidateCache: Bool) {
        Task {
            try await Task.sleep(for: .seconds(0.5))
            await movieCatalogModel.loadMoviesFromAllEndpoints(invalidateCache: invalidateCache)
        }
    }
}

#if DEBUG
struct MovieCatalog_Previews : PreviewProvider {
    static var previews: some View {
        //TabView {
        MovieCatalogView()
            .environmentObject(sampleState)
        //}
    }
}
#endif
