////
////  People.swift
////  MovieApp
////
////  Created by valod on 24.05.23.
////
//
//import Foundation
//
//{
//  "adult": false,
//  "also_known_as": [
//    "クリス・プラット",
//    "کریس پرت"
//  ],
//  "biography": "Christopher Michael Pratt (born 21 June 1979) is an American actor, known for starring in both television and action films. He rose to prominence for his television roles, particularly in the NBC sitcom Parks and Recreation (2009–2015), for which he received critical acclaim and was nominated for the Critics' Choice Television Award for Best Supporting Actor in a Comedy Series in 2013. He also starred earlier in his career as Bright Abbott in The WB drama series Everwood (2002–2006) and had roles in Wanted (2008), Jennifer's Body (2009), Moneyball (2011), The Five-Year Engagement (2012), Zero Dark Thirty (2013), Delivery Man (2013), and Her (2013).\n\nPratt achieved leading man status in 2014, starring in two critically and commercially successful films: The Lego Movie as Emmet Brickowski, and Marvel Studios' Guardians of the Galaxy as Star-Lord. He starred in Jurassic World (2015) and Jurassic World: Fallen Kingdom (2018), and he reprised his Marvel role in Guardians of the Galaxy Vol. 2 (2017), Avengers: Infinity War (2018), Avengers: Endgame (2019), and the planned Guardians of the Galaxy Vol. 3. Meanwhile, in 2016 he was part of an ensemble cast in The Magnificent Seven and the male lead in Passengers.\n\nDescription above is from the Wikipedia article Chris Pratt, licensed under CC-BY-SA, full list of contributors on Wikipedia.",
//  "birthday": "1979-06-21",
//  "deathday": null,
//  "gender": 2,
//  "homepage": null,
//  "id": 73457,
//  "imdb_id": "nm0695435",
//  "known_for_department": "Acting",
//  "name": "Chris Pratt",
//  "place_of_birth": "Virginia, Minnesota, USA",
//  "popularity": 87.01,
//  "profile_path": "/83o3koL82jt30EJ0rz4Bnzrt2dd.jpg"
//}
//
//import Foundation
//
//struct Response<T: Codable>: Codable {
//    let page: Int?
//    let total_results: Int?
//    let total_pages: Int?
//    let results: [T]
//}
//
//
//struct Movie: Codable, Identifiable {
//    let id: Int
//    
//    let original_title: String
//    let title: String
//    
//    let overview: String
//    let poster_path: String?
//    let backdrop_path: String?
//    let popularity: Float
//    let vote_average: Float
//    let vote_count: Int
//    
//    let release_date: String?
//   
//    var credits: MovieCredit?
//    var videos: [MovieVideo]?
//    
//    let runtime: Int?
//    let status: String?
//    let video: Bool
//    
//    var images: MovieImages?
//    
//    var production_countries: [productionCountry]?
//    
//    var character: String?
//    var department: String?
//    
//    var genres: [MovieGenre]?
//    
//    var userTitle: String { return AppConfig.alwaysOriginalTitle ? original_title : title }
//    
//    var durationText: String {
//        let formatter = DateComponentsFormatter()
//        formatter.unitsStyle = .abbreviated
//        formatter.allowedUnits = [.hour, .minute]
//        guard let runtime = runtime else { return "n/a" }
//        return formatter.string(from: TimeInterval(runtime)*60) ?? "n/a"
//    }
//    
//    var releaseDate: Date {
//        guard let date = release_date else { return Date() }
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter.date(from: date) ?? Date()
//    }
//
//    var releaseYear: String { releaseDate.get(.year).description } // ?? "n/a" }
//    
//    var directors: [MovieCrew]? { credits?.crew.filter { $0.job.lowercased() == "director" } }
//    var producers: [MovieCrew]? { credits?.crew.filter { $0.job.lowercased() == "producer" } }
//    
//    var directorsNameList: [String]? { directors?.map({ $0.name }) }
//    var producersNameList: [String]? { producers?.map({ $0.name }) }
//    
//    var youtubeTrailers: [MovieVideo]? { videos?.filter { $0.youtubeURL != nil } }
//}
