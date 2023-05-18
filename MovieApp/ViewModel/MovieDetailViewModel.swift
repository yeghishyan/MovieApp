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
        debugPrint("debug")
    }
    
    func loadMovie(id: Int) async {
        if Task.isCancelled { return }
        phase = .empty
        
        do {
            let movie = try await self.movieService.fetchMovie(movieId: id)
            phase = .success(movie)
        } catch {
            phase = .failure(error)
        }
    }
    
    func loadMovieVideo(id: Int) async {
        guard var movie = movie, Task.isCancelled else { return }
        phase = .empty
        
        do {
            movie.videos = try await self.movieService.fetchVideo(movieId: id)
            phase = .success(movie)
        } catch {
            phase = .failure(error)
        }
    }
    
    func loadMovieCredit(id: Int) async {
        guard var movie = movie, Task.isCancelled else { return }
        phase = .empty
        
        do {
            movie.credits = try await self.movieService.fetchCredit(movieId: id)
            phase = .success(movie)
        } catch {
            phase = .failure(error)
        }
    }
}
