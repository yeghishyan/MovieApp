//
//  MovieService.swift
//

import Foundation

struct MovieService {
    static let shared = MovieService()
    
    private init() {}
    private let api = MovieAPI.shared
    
    func fetchMovies(from list: MovieListEndpoint) async throws -> [Movie] {
        let endpoint = list.endpoint()
        
        let movieResponse: Response<Movie> = try await api.GET(endpoint: endpoint, params: nil)
        return movieResponse.results
    }
    
    func searchMovie(query: String) async throws -> [Movie] {
        let endpoint = MovieEndpoint.searchMovie
        let params = [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ]
        
        let movieResponse: Response<Movie> = try await api.GET(endpoint: endpoint, params: params)
        return movieResponse.results
    }
    
    func fetchMovie(movieId: Int) async throws -> Movie {
        let endpoint = MovieEndpoint.movieDetail(movie: movieId)
        
        let movieResponse: Movie = try await api.GET(endpoint: endpoint, params: nil)
        return movieResponse
    }
    
    func fetchVideo(movieId: Int) async throws -> [MovieVideo] {
        let endpoint = MovieEndpoint.videos(movie: movieId)
        
        let movieResponse: Response<MovieVideo> = try await api.GET(endpoint: endpoint, params: nil)
        return movieResponse.results
    }
    
    func fetchCredit(movieId: Int) async throws -> MovieCredit {
        let endpoint = MovieEndpoint.credits(movie: movieId)
        
        let movieResponse: MovieCredit = try await api.GET(endpoint: endpoint, params: nil)
        return movieResponse
    }
    
    func fetchDiscover(params: [String: String]) async throws -> [Movie] {
        let endpoint = MovieEndpoint.discover
        var queryParams = params
        queryParams["sort_by"] = "popularity.desc"
        
        let movieResponse: Response<Movie> = try await api.GET(endpoint: endpoint, params: queryParams)
        return movieResponse.results
    }
    
//    func fetchGenres() async throws -> [MovieGenre] {
//        let endpoint = MovieEndpoint.genres
//
//        let movieResponse: GenresResponse = try await api.GET(endpoint: endpoint, params: nil)
//        return movieResponse.genres
//    }
    
}
