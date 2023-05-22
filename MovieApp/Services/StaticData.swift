//
//  OfflineMode.swift
//  MovieApp
//
//  Created by valod on 15.05.23.
//

import Foundation

extension Movie {
    static var stubbedMovies: [Movie] {
        let response: Response<Movie>? = try? Bundle.main.loadAndDecodeJSON(filename: "discover")
        //debugPrint(response?.results.first)
        return response!.results
    }
}

extension Bundle {
    func loadAndDecodeJSON<T: Decodable>(filename: String) throws -> T? {
        guard let path = self.path(forResource: filename, ofType: "json") else { return nil }
        let data = try Data(contentsOf: URL(filePath: path))
        let jsonDecoder = JSONDecoder()
        let decodedModel = try jsonDecoder.decode(T.self, from: data)
        return decodedModel
    }
}
