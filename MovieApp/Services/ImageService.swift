//
//  ImageService.swift
//

import SwiftUI
import Combine
import UIKit

final class ImageService {
    static let shared = ImageService()
    
    enum Size: String {
        case ld = "https://image.tmdb.org/t/p/w300"
        case sd = "https://image.tmdb.org/t/p/w500"
        case hd = "https://image.tmdb.org/t/p/w780/"
        case fullHd = "https://image.tmdb.org/t/p/w1280"
        case original = "https://image.tmdb.org/t/p/original"
        
        func path(imagePath: String) -> URL {
            return URL(string: rawValue)!.appendingPathComponent(imagePath)
        }
    }
    
    enum ImageError: Error {
        case decodingError
    }
    
    func fetchImage(imagePath: String, size: Size) -> AnyPublisher<UIImage?, Never> {
        return URLSession.shared.dataTaskPublisher(for: size.path(imagePath: imagePath))
            .tryMap { (data, response) -> UIImage? in
                return UIImage(data: data)
        }.catch { error in
            return Just(nil)
        }
        .eraseToAnyPublisher()
    }
}
