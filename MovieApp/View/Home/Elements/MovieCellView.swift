//
//  MovieThumbnailView.swift
//

import SwiftUI

fileprivate let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

struct MovieCellView: View {
    @ObservedObject var imageLoader: ImageLoader
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        imageLoader = ImageLoader(imagePath: movie.backdrop_path)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            image
                .shadow(radius: 5)
                .cornerRadius(9)
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    Text(movie.title)
                        .overlay(alignment: .leading) {
                            image.blur(radius: 10)
                        }
                        .mask(Text(movie.title))
                        .overlay {
                            Text(movie.title)
                                .tint(.steam_foreground)
                        }
                }
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .font(.oswald(size: 23, weight: .heavy))
                
                HStack(spacing: 15) {
                    CircleRating(score: Int(movie.vote_average * 10))
                    Text(formatter.string(from: movie.releaseDate ?? Date()))
                        .font(.subheadline)
                        .foregroundColor(.steam_gold)
                        .lineLimit(1)
                }.padding(.leading, 5)

                VStack(alignment: .leading) {
                    Text(movie.overview)
                        .truncationMode(.tail)
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                        .foregroundColor(.secondary)
                        .font(.system(size: 15))
                }
            }
        }
        //.contextMenu{MovieContextMenu(movieId: self.movieId) }
    }
    
    private var image: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Rectangle()
                    .foregroundColor(.gray)
            }
        }
    }
}

#if DEBUG
struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieCellView(movie: Movie.stubbedMovies[15])
        }
    }
}
#endif
