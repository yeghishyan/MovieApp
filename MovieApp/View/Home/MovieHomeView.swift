//
//  MovieHomeView.swift
//

import SwiftUI

struct MovieHomeView: View {
    @StateObject private var movieHomeModel = MovieDiscoverViewModel()
    @State private var activePage: Int = 0
    
    //var proxy: ScrollViewProxy
    //var size: CGSize
    //var safeArea: EdgeInsets
    
    @ViewBuilder
    private func headerSection() -> some View {
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
                .fill(Color.steam_gold)
        }
        .padding(.horizontal, 30)
    }
    
    @ViewBuilder
    private func posterCard() -> some View {
        TabView(selection: $activePage) {
            ForEach(movieHomeModel.movies) { movie in
                MovieCardView(movieId: movie.id)
                    .tag(index(movie))
                    
            }
        }.scaledToFill()
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    var body: some View {
        VStack {
            headerSection()
            Capsule()
                .fill(.gray.opacity(0.2))
                .frame(width: 50, height: 5)
                .padding(.vertical, 5)
            
            ScrollView(.vertical, showsIndicators: false) {
                posterCard()
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
