//
//  MovieCredit.swift
//

import Foundation

struct MovieCast: Codable, Identifiable {
    let id: Int
    let character: String
    let name: String
    let profile_path: String?
}

struct MovieCrew: Codable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

struct MovieCredit: Codable {
    var cast: [MovieCast]
    var crew: [MovieCrew]
}
