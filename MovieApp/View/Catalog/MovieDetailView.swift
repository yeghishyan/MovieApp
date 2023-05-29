//
//  MovieDetailView.swift
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var movieDetailModel = MovieDetailViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isPortrait: Bool { verticalSizeClass == .regular }

    let movie: Movie
    
    @State private var isFavorite: Bool = false
    
    private var glassMorphicField: some View {
        ZStack {
            GlassMorphicView(effect: .systemUltraThinMaterialDark) { view in
                view.saturationAmount = 10
                view.gaussianBlurValue = 20
            }
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.steam_theme.opacity(0.1),
                                 .clear],
                        startPoint: .top,
                        endPoint: .bottom)
                )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [.steam_gold.opacity(0.25),
                                 .steam_foreground.opacity(0.45)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing),
                    lineWidth: 3)
        }
        //.overlay { content }
        .padding(.horizontal, 5)
    }
    
    var body: some View {
        ZStack {
            if let movie = movieDetailModel.movie {
                ScrollView(showsIndicators: false) {
                    VStack {
                        MovieHeaderImage(imagePath: (isPortrait ? movie.poster_path : movie.backdrop_path))
                                
                        ZStack {
                            glassMorphicField
                                .opacity(0.98)
                            VStack(alignment: .leading, spacing: 10) {
                                MovieDetailInfo(movie: movie)
                                Divider()
                                MovieCreditView(movie: movie)
                                Divider()
                                SimilarMoviesView(movie: movie)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .padding(.trailing, 10)
                        }
                        .padding(.top, isPortrait ? -300 : -450)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .task { loadMovieDetails() }
        .overlay(DataLoadingView(
            phase: movieDetailModel.phase,
            retryAction: loadMovieDetails)
        )
        .toolbar{ ToolbarItem(placement: .navigationBarTrailing) {
            NavigationFavoriteButton(isFavorite: $isFavorite)
        }}
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    private func loadMovieDetails() {
        Task {
            await movieDetailModel.loadMovieDetails(id: self.movie.id)
        }
    }
}

#if DEBUG
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.stubbedMovies[3])
    }
}
#endif
