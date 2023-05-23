//
//  Movie.swift
//

import Foundation

struct Response<T: Codable>: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [T]
}


struct Movie: Codable, Identifiable {
    let id: Int
    
    let original_title: String
    let title: String
    
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let popularity: Float
    let vote_average: Float
    let vote_count: Int
    
    let release_date: String?
   
    var credits: MovieCredit?
    var videos: [MovieVideo]?
    
    let runtime: Int?
    let status: String?
    let video: Bool
    
    var images: MovieImages?
    
    var production_countries: [productionCountry]?
    
    var character: String?
    var department: String?
    
    var genre_ids: [Int]?
    
    var userTitle: String { return AppConfig.alwaysOriginalTitle ? original_title : title }
    
    var durationText: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        guard let runtime = runtime else { return "n/a" }
        return formatter.string(from: TimeInterval(runtime)*60) ?? "n/a"
    }
    
    var releaseDate: Date {
        guard let date = release_date else { return Date() }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter.date(from: date) ?? Date()
    }

    var releaseYear: String { releaseDate.get(.year).description } // ?? "n/a" }
    
    var directors: [MovieCrew]? { credits?.crew.filter { $0.job.lowercased() == "director" } }
    var producers: [MovieCrew]? { credits?.crew.filter { $0.job.lowercased() == "producer" } }
    
    var youtubeTrailers: [MovieVideo]? { videos?.filter { $0.youtubeURL != nil } }
}
