//
//  MovieDetailState.swift
//

import SwiftUI

@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published private(set) var phase: DataFetchPhase<Movie?> = .empty
    
    private let movieService: MovieService
    var movie: Movie? { phase.value ?? nil }
    
    init(movieService: MovieService = MovieService.shared) {
        self.movieService = movieService
    }
    
    func loadMovieDetails(id: Int, invalidateCache: Bool = false) async {
        if case .success = phase, !invalidateCache { return }
        phase = .empty
        
        do {
            var movie = try await self.movieService.fetchMovie(movieId: id)
            movie.videos = try await self.movieService.fetchVideo(movieId: id)
            movie.credits = try await self.movieService.fetchCredit(movieId: id)
            
            if Task.isCancelled { return }
            phase = .success(movie)
        } catch {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
}
