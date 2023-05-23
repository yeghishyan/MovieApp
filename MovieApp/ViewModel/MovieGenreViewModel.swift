//
//  MovieGenreState.swift
//

import SwiftUI

@MainActor
class MovieGenreViewModel: ObservableObject {
    @Published private(set) var phase: DataFetchPhase<[Movie]?> = .empty
    private let movieService: MovieService
    
    var movies: [Movie]? { phase.value ?? nil }
        
    init(movieService: MovieService = MovieService.shared) {
        self.movieService = movieService
    }
    
    func loadGenres(genre: MovieGenre) async {
        if Task.isCancelled { return }
        phase = .empty
     
        do {
            let movie = try await self.movieService.fetchGenres(genre: genre)
            phase = .success(movie)
        } catch {
            phase = .failure(error)
        }
    }
}
