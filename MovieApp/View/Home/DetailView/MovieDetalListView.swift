//
//  MovieDetalListView.swift
//

import SwiftUI

struct MovieDetailListView: View {
    let movie: Movie
    //@Binding var selectedTrailerURL: URL?
    
    var body: some View {
        List {
            MovieGenreView(movie: movie)
            movieRatingSection
            movieDescriptionSection.listRowSeparator(.visible)
            movieCastSection.listRowSeparator(.hidden)
            movieTrailerSection
        }
    }
    
    private var movieDescriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(movie.overview)
            
        }
        .padding(.vertical)
    }
    
    private var movieRatingSection: some View {
        HStack {
            if movie.vote_average != 0 {
                Text(String(movie.vote_average)).foregroundColor(.yellow)
            }
        }
    }
    
    private var movieCastSection: some View {
        HStack(alignment: .top, spacing: 4) {
            if let cast = movie.credits?.cast, !cast.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Starring")
                        .font(.headline)
                    ForEach(cast.prefix(9)) { Text($0.name) }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Spacer()
                
            }
            
            if let crew = movie.credits?.crew, !crew.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    if let directors = movie.directors, !directors.isEmpty {
                        Text("Director(s)").font(.headline)
                        ForEach(directors.prefix(2)) { Text($0.name) }
                    }
                    
                    if let producers = movie.producers, !producers.isEmpty {
                        Text("Producer(s)").font(.headline)
                            .padding(.top)
                        ForEach(producers.prefix(2)) { Text($0.name) }
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    private var movieTrailerSection: some View {
        if let trailers = movie.youtubeTrailers, !trailers.isEmpty {
            Text("Trailers").font(.headline)
            ForEach(trailers) { trailer in
                Button(action: {
                    guard let url = trailer.youtubeURL else { return }
                    //selectedTrailerURL = url
                }) {
                    HStack {
                        Text(trailer.name)
                        Spacer()
                        Image(systemName: "play.circle.fill")
                            .foregroundColor(Color(UIColor.systemBlue))
                    }
                }
            }
        }
    }
}

#if DEBUG
struct MovieDetailList_Preview: PreviewProvider {
    static var previews: some View {
        MovieDetailListView(movie: Movie.stubbedMovie)
    }
}
#endif
