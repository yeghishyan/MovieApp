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
    
    var body: some View {
        NavigationStack {
            VStack {
                headerSection()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        ForEach(movieHomeModel.movies) { movie in
                            GeometryReader { proxy in
                                let minX = Double(proxy.frame(in: .global).minX)
                                MovieCardView(movieId: movie.id)
                                    .tag(index(movie))
                                    .rotation3DEffect(
                                        Angle(degrees: (minX ) / -40),
                                        axis: (x: 0, y: 1, z: 0)
                                    )
                                //.blur(radius: minX/4)
                            }
                            .frame(width: 300, height: 380)
                            //.border(.black)
                        }
                    }
                    .padding(30)
                    Spacer()
                }
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
