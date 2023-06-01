//
//  MovieVideo.swift
//
import Foundation

struct MovieVideo: Codable, Identifiable {
    let id: String
    let name: String
    let site: String
    let key: String
    let type: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else { return nil }
        return URL(string: "https://youtube.com/embed/\(key)")
    }
}
