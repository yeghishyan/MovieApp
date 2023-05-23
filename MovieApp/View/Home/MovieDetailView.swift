//
//  MovieDetailView.swift
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var movieDetailState = MovieDetailViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.verticalSizeClass) var verticalSizeClass

    let movie: Movie
    
    //TODO move to AppState
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ZStack {
            MovieDetailImage(imagePath: (verticalSizeClass == .regular ? movie.poster_path : movie.backdrop_path))
            
            if let movie = movieDetailState.movie {
                ScrollView {
                    Spacer()
                        .frame(minHeight: 200)
                    MovieDetailInfo(movie: movie)
                }
            }
            
        }
        .task { loadMovieDetails() }
        .overlay(DataLoadingView(
            phase: movieDetailState.phase,
            retryAction: loadMovieDetails)
        )
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbar{ToolbarItem(placement: .navigationBarLeading) {
            NavigationBackButton(dismiss: dismiss)
        }}
        .toolbar{ ToolbarItem(placement: .navigationBarTrailing) {
            NavigationFavoriteButton(isFavorite: $isFavorite)
        }}
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    private func loadMovieDetails() {
        Task {
            await movieDetailState.loadMovieDetails(id: self.movie.id)
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
