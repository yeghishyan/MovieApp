//
//  MovieListState.swift
//

import SwiftUI

final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let movieService: MovieService
    
    init(movieService: MovieService = MovieService.shared) {
        self.movieService = movieService
    }
    
    func loadMovies(with endpoint: MovieListEndpoint) async {
          self.movies = nil
          self.isLoading = true
          
          do {
              let movies = try await movieService.fetchMovies(from: endpoint)
              self.isLoading = false
              self.movies = movies
              
          } catch {
              self.isLoading = false
              self.error = error as NSError
          }
      }
    
}
