//
//  Endpoint.swift
//

import Foundation

enum MovieSectionEndpoint: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    
    case nowPlaying
    case upcoming
    case topRated
    case popular
    
    func title() -> String {
        switch self {
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        case .nowPlaying: return "Now Playing"
        }
    }
    
    func endpoint() -> MovieEndpoint {
        switch self {
        case .nowPlaying: return MovieEndpoint.nowPlaying
        case .upcoming: return MovieEndpoint.upcoming
        case .topRated: return MovieEndpoint.topRated
        case .popular: return MovieEndpoint.popular
        }
    }
}
enum MovieEndpoint {
    case popular, topRated, upcoming, nowPlaying, trending, genres
    case searchMovie
    case discover
    case movieDetail(movie: Int)
    case recommended(movie: Int)
    case similar(movie: Int)
    case credits(movie: Int)
    case videos(movie: Int)
    case images(movie: Int)
    
    func path() -> String {
        switch self {
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .nowPlaying:
            return "movie/now_playing"
        case .trending:
            return "trending/movie/day"
        case .genres:
            return "genre/movie/list"
        case .searchMovie:
            return "search/movie"
        case .discover:
            return "discover/movie"
        case let .movieDetail(movie):
            return "movie/\(String(movie))"
        case let .videos(movie):
            return "movie/\(String(movie))/videos"
        case let .credits(movie):
            return "movie/\(String(movie))/credits"
        case let .recommended(movie):
            return "movie/\(String(movie))/recommendations"
        case let .similar(movie):
            return "movie/\(String(movie))/similar"
        case let .images(movie):
            return "movie/\(String(movie))/images"
        }
    }
}
