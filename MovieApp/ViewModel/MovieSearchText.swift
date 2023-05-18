////
////  MovieSearchText.swift
////
//
//import SwiftUI
//
//final class MoviesSearchText: ObservedObject {
//    @Published var movies: [Movie]?
//    @Published var isLoading: Bool = false
//    @Published var error: NSError?
//
//    private let movieService: MovieService = MovieService.shared
//
//    var text: String?
//
//    func loadSearchResult() async {
//        guard let text = text, !text.isEmpty else { return }
//
//        do {
//            let movies = try await movieService.searchMovie(query: text)
//            self.isLoading = false
//            self.movies = movies
//
//        } catch {
//            self.isLoading = false
//            self.error = error as NSError
//        }
//    }
//}
