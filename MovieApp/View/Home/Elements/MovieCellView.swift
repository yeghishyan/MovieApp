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
    let movie: Movie
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            image()
                .resizable()
                .posterStyle(size: .medium)
                .shadow(radius: 5)
                .cornerRadius(9)
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    Text(movie.title)
                        .overlay(alignment: .leading) {
                            image().blur(radius: 10)
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
        .onAppear { imageLoader.loadImage(with: movie.poster_path) }
        //.contextMenu{MovieContextMenu(movieId: self.movieId) }
    }
    
    private func image() -> Image {
        if let image = imageLoader.image {
            return Image(uiImage: image)
        }
        return Image(uiImage: UIImage())
    }
}

#if DEBUG
struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieCellView(movie: Movie.stubbedMovies[15])
                .aspectRatio(9/16, contentMode: .fit)
                .frame(width: 360)
        }
    }
}
#endif
