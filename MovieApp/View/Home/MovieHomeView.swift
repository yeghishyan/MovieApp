//
//  MovieHomeView.swift
//

import SwiftUI

struct MovieHomeView: View {
    @StateObject private var movieHomeModel = MovieDiscoverViewModel()
    @State private var activePage: Int = 0
    
    @ViewBuilder
    private func headerSection() -> some View {
        VStack {
            HStack(spacing: 4) {
                Text ("Discover by year")
                    .font(.oswald(size: 15))
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Image(systemName: "calendar.badge.clock")
                    .imageScale(.large)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .background {
                RoundedRectangle(cornerRadius: 35, style: .continuous)
                    .fill(Color.steam_background)
            }
            .padding(.horizontal, 30)
            
            Capsule()
                .fill(.gray.opacity(0.2))
                .frame(width: 50, height: 5)
                .padding(.vertical, 5)
        }
    }
    
    private var searchButton: some View {
        NavigationLink(destination: {
            SearchableViewParent() {}
        }) {
            Image(systemName: "magnifyingglass.circle")
                .resizable()
                .imageScale(.large)
                .frame(width: 25, height: 25, alignment: .center)
                .offset(y: -5)
        }
        .frame(width: 44, height: 44, alignment: .center)
        .tint(Color.steam_foreground)
    }
    
    private var menuButton: some View {
        Button(action: {
            
        }) {
            Image(systemName: "line.3.horizontal.circle")
                .resizable()
                .imageScale(.large)
                .frame(width: 25, height: 25, alignment: .center)
        }
        .frame(width: 44, height: 44, alignment: .center)
        .tint(Color.steam_foreground).offset(y: -5)
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                MovieHomeViewProxy(movies: movieHomeModel.movies, size: size)
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { menuButton }
                ToolbarItem(placement: .navigationBarTrailing) { searchButton }
            }
        }
        .task { loadMovies(invalidateCache: false) }
        .overlay(DataLoadingView(
            phase: movieHomeModel.phase,
            retryAction: { loadMovies(invalidateCache: true) })
        )
    }
    
    private func loadMovies(invalidateCache: Bool = false) {
        Task { await movieHomeModel.loadMovies(
            param: .year,
            value: "2023", //Calendar.current.component(.year, from: Date()).description
            invalidateCache: invalidateCache
            )
        }
    }
    
    private func index(_ of: Movie) -> Int {
        return movieHomeModel.movies.firstIndex(of: of) ?? 0
    }
}

#if DEBUG
struct MovieHome_Previews : PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}
#endif
