//
//  MovieService.swift
//

import Foundation

struct MovieService {
    static let shared = MovieService()
    
    private init() {}
    private let api = MovieAPI.shared
    
    func fetchMovies(from list: MovieSectionEndpoint) async throws -> [Movie] {
        let endpoint = list.endpoint()
        
        let responseData: Response<Movie> = try await api.GET(endpoint: endpoint, params: nil)
        return responseData.results
    }
    
    func searchMovie(query: String) async throws -> [Movie] {
        let endpoint = MovieEndpoint.searchMovie
        let params = [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ]
        
        let responseData: Response<Movie> = try await api.GET(endpoint: endpoint, params: params)
        return responseData.results
    }
    
    func fetchMovie(movieId: Int) async throws -> Movie {
        let endpoint = MovieEndpoint.movieDetail(movie: movieId)
        
        let responseData: Movie = try await api.GET(endpoint: endpoint, params: nil)
        return responseData
    }
    
    func fetchVideo(movieId: Int) async throws -> [MovieVideo] {
        let endpoint = MovieEndpoint.videos(movie: movieId)
        
        let responseData: Response<MovieVideo> = try await api.GET(endpoint: endpoint, params: nil)
        return responseData.results
    }
    
    func fetchCredit(movieId: Int) async throws -> MovieCredit {
        let endpoint = MovieEndpoint.credits(movie: movieId)
        
        let responseData: MovieCredit = try await api.GET(endpoint: endpoint, params: nil)
        return responseData
    }
    
    func fetchDiscover(params: [String: String]) async throws -> [Movie] {
        let endpoint = MovieEndpoint.discover
        var queryParams = params
        queryParams["sort_by"] = "popularity.desc"
        
        let responseData: Response<Movie> = try await api.GET(endpoint: endpoint, params: queryParams)
        return responseData.results
    }
    
    func fetchSimilar(movieId: Int) async throws -> [Movie] {
        let endpoint = MovieEndpoint.similar(movie: movieId)
        
        let responseData: Response<Movie> = try await api.GET(endpoint: endpoint, params: nil)
        return responseData.results
    }
    
    func fetchMovieImages(movieId: Int) async throws -> MovieImages {
        let endpoint = MovieEndpoint.images(movie: movieId)
        
        let responseData: MovieImages = try await api.GET(endpoint: endpoint, params: nil)
        return responseData
    }
    
//    func fetchGenres() async throws -> [MovieGenre] {
//        let endpoint = MovieEndpoint.genres
//
//        let responseData: GenresResponse = try await api.GET(endpoint: endpoint, params: nil)
//        return responseData.genres
//    }
    
}
