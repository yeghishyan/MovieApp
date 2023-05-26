//
//  SimilarMoviesViewModel.swift
//

import SwiftUI

@MainActor
class SimilarMoviesViewModel: ObservableObject {
    @Published var phase: DataFetchPhase<[Movie]> = .empty
    private var movieService: MovieService
    
    var movies: [Movie] { phase.value ?? [] }
    
    init(movieService: MovieService = .shared) {
        self.movieService = movieService
    }
    
    func fetchSimilarMovies(movieId: Int) async {
        if case .success = phase { return }
        phase = .empty
        
        do {
            let movies = try await movieService.fetchSimilar(movieId: movieId)
            
            if Task.isCancelled { return }
            phase = .success(movies.filter { $0.poster_path != nil })
        }
        catch {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
}
