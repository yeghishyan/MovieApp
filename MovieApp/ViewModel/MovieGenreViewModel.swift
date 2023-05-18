//
//  MovieGenreState.swift
//

import SwiftUI

@MainActor
class MovieGenreViewModel: ObservableObject {
    @Published private(set) var phase: DataFetchPhase<[MovieGenre]?> = .empty
    
    private let movieService: MovieService
    var genres: [MovieGenre]? { phase.value ?? nil }
    
    init(movieService: MovieService = MovieService.shared) {
        self.movieService = movieService
    }
    
    func name(id: Int) -> String { return genres?.first(where: { $0.id == id })?.name ?? "n/a" }
    
    func loadGenres() async {
        if Task.isCancelled { return }
        phase = .empty
     
        do {
            let genres = try await self.movieService.fetchGenres()
            phase = .success(genres)
        } catch {
            phase = .failure(error)
        }
    }
}
