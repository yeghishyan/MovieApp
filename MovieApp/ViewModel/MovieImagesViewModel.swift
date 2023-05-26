//
//  MovieImagesViewModel.swift
//

import SwiftUI

@MainActor
class MovieImagesViewModel: ObservableObject {
    @Published var phase: DataFetchPhase<MovieImages?> = .empty
    private var movieService: MovieService
    
    var images: MovieImages? { phase.value ?? nil }
    
    init(movieService: MovieService = .shared) {
        self.movieService = movieService
    }
    
    func fetchMovieImages(movieId: Int) async {
        if case .success = phase { return }
        phase = .empty
        
        do {
            let images = try await movieService.fetchMovieImages(movieId: movieId)
            
            if Task.isCancelled { return }
            phase = .success(images)
        }
        catch {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
}
