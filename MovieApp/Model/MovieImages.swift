//
//  MovieImages.swift
//

import Foundation

struct MovieImages: Codable {
    struct ImageData: Codable, Identifiable {
        var id: String { file_path }
        let aspect_ratio: Float
        let file_path: String
        let height: Int
        let width: Int
    }
    
    let posters: [ImageData]?
    let backdrops: [ImageData]?
}
