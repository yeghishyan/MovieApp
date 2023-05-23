//
//  APIService.swift
//

import Foundation

enum MovieAPIError: Error, CustomNSError {
    case apiError
    case noResponseData
    case invalidEndpoint
    case invalidResponse
    case serializationError(Error)
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .noResponseData: return "No response data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .serializationError(let error): return "Failed to decode data.\n \(error.localizedDescription)"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}

struct MovieAPI {
    let baseURL = URL(string: "https://api.themoviedb.org/3")!
    let apiKey = "0e15af59bdfb7a0361a6ebb9a50575ed"
    
    static let shared = MovieAPI()
    let decoder = JSONDecoder()
    
    func GET<T: Codable>(endpoint: MovieEndpoint, params: [String: String]?) async throws -> T {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        guard var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true) else { throw MovieAPIError.invalidEndpoint }
        
        components.queryItems = [
           URLQueryItem(name: "api_key", value: apiKey),
           URLQueryItem(name: "language", value: Locale.preferredLanguages[0])
        ]
        
        if let params = params {
            components.queryItems?.append(contentsOf: params.map { value in
                URLQueryItem(name: value.key, value: value.value)
            })
        }
        
        guard let finalURL = components.url else { throw MovieAPIError.invalidEndpoint }
                
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw MovieAPIError.invalidResponse
        }
        
        //debugPrint(finalURL)
        
        do {
            let data = try self.decoder.decode(T.self, from: data);
            return data
        } catch {
            throw MovieAPIError.serializationError(error)
        }
    }
}

