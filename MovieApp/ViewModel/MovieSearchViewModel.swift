//
//  MovieSearchModel.swift
//

import SwiftUI

@MainActor
class MovieSearchViewModel: ObservableObject {
    @Published private(set) var phase: DataFetchPhase<[Movie]> = .empty
    @Published var searchText: String

    private let movieService: MovieService = MovieService.shared
    
    var movies: [Movie] { phase.value ?? [] }

    init(searchText: String = "") {
        self.searchText = searchText
    }
    
    func loadSearchResult() async {
        if case .success = phase, searchText.isEmpty { return }
        phase = .empty
        
        do {
            let movies = try await movieService.searchMovie(query: searchText)
            
            if Task.isCancelled { return }
            phase = .success(movies)
        } catch {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
}
