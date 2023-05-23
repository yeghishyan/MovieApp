//
//  MovieDetailView.swift
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var movieDetailState = MovieDetailViewModel()
    @Environment(\.dismiss) private var dismiss
    let movie: Movie
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            ZStack {
                GlassMorphicView(effect: .systemUltraThinMaterialDark) { view in
                    view.gaussianBlurValue = 20
                    view.saturationAmount = 10
                }
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                Image(systemName: "chevron.backward")
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
            }
        }
    }
    
    var body: some View {
        ZStack {
            MovieDetailImage(imagePath: movie.poster_path)
            if let movie = movieDetailState.movie {
                ScrollView {
                    MovieDetailInfo(movie: movie)
                        .offset(y: 500)
                }
            }
        }
        .task { loadMovieDetails() }
        .overlay(DataLoadingView(
            phase: movieDetailState.phase,
            retryAction: loadMovieDetails)
        )
        .navigationTitle(movie.userTitle)
        .navigationBarBackButtonHidden(true)
        .toolbar{ ToolbarItem(placement: .navigationBarLeading) { backButton } }
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
        MovieDetailView(movie: Movie.stubbedMovies[1])
    }
}
#endif
