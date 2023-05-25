//
//  MovieGenreState.swift
//

import SwiftUI

@MainActor
class MovieDiscoverViewModel: ObservableObject {
    enum DiscoverParam: String {
        case genre = "with_genres"
        case cast = "with_cast"
        case crew = "with_crew"
        case people = "with_people"
        case year = "year"
    }
    
    @Published private(set) var phase: DataFetchPhase<[Movie]?> = .empty
    private let movieService: MovieService
    
    var movies: [Movie]? { phase.value ?? nil }
        
    init(movieService: MovieService = MovieService.shared) {
        self.movieService = movieService
    }
    
    func loadMovies(param: DiscoverParam, value: String) async {
        if Task.isCancelled { return }
        phase = .empty
     
        do {
            let movie = try await self.movieService.fetchDiscover(params: [param.rawValue: value])
            phase = .success(movie)
        } catch {
            phase = .failure(error)
        }
    }
}
