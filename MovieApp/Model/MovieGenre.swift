//
//  MovieGenre.swift
//  

import Foundation

struct GenresResponse: Codable {
    let genres: [MovieGenre]
}

struct MovieGenre: Codable, Identifiable {
    let id: Int
    var name: String
}

