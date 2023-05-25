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
    
    //TODO move to AppState
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ZStack {
            MovieDetailImage(imagePath: (isPortrait ? movie.poster_path : movie.backdrop_path))
            
            if let movie = movieDetailModel.movie {
                ScrollView(showsIndicators: false) {
                    Spacer()
                        .frame(minHeight: isPortrait ? 300 : 200)
                    MovieDetailInfo(movie: movie)
                }
            }
        }
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
        MovieDetailView(movie: Movie.stubbedMovies[2])
    }
}
#endif
