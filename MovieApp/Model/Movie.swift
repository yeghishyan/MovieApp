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
    
    var genres: [MovieGenre]?
    
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


/*
 {
    "adult":false,
    "belongs_to_collection":{
       "id":9485,
       "name":"The Fast and the Furious Collection",
       "poster_path":"/vEq10ZynOwHaSIIQ3mWohbHzvRb.jpg",
       "backdrop_path":"/z5A5W3WYJc3UVEWljSGwdjDgQ0j.jpg"
    },
    "budget":340000000,
    "genres":[
       {
          "id":28,
          "name":"Action"
       },
       {
          "id":80,
          "name":"Crime"
       },
       {
          "id":53,
          "name":"Thriller"
       }
    ],
    "homepage":"https://fastxmovie.com",
    
    "imdb_id":"tt5433140",
    "production_companies":[
       {
          "id":33,
          "logo_path":"/8lvHyhjr8oUKOOy2dKXoALWKdp0.png",
          "name":"Universal Pictures",
          "origin_country":"US"
       },
       {
          "id":333,
          "logo_path":"/5xUJfzPZ8jWJUDzYtIeuPO4qPIa.png",
          "name":"Original Film",
          "origin_country":"US"
       },
       {
          "id":1225,
          "logo_path":"/rIxhJMR7oK8b2fMakmTfRLY2TZv.png",
          "name":"One Race",
          "origin_country":"US"
       },
       {
          "id":34530,
          "logo_path":null,
          "name":"Perfect Storm Entertainment",
          "origin_country":"US"
       }
    ],
    "production_countries":[
       {
          "iso_3166_1":"US",
          "name":"United States of America"
       }
    ],
    "revenue":267300000,
    "runtime":142,
    "spoken_languages":[
       {
          "english_name":"English",
          "iso_639_1":"en",
          "name":"English"
       },
       {
          "english_name":"Portuguese",
          "iso_639_1":"pt",
          "name":"Português"
       }
    ],
    "status":"Released",
    "tagline":"The end of the road begins.",
    "title":"Fast X",
    "video":false,
 }
 */
