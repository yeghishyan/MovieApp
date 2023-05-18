//
//  MoviePoster.swift
//

import SwiftUI

fileprivate let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

struct MoviePoster: View {
    let movie: Movie
    @StateObject var imageLoader = ImageLoader()
    @State var scale = 1.0

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            image()
                .resizable()
                .scaledToFit()
                .overlay(alignment: .topTrailing, content: {
                    CircleRating(score: Int(movie.vote_average * 10), size: 30)
                        .padding([.trailing, .top], 10)
                })
                .onAppear { imageLoader.loadImage(with: movie.poster_path) }
                .posterStyle(size: .medium)
                .shadow(color: .black.opacity(0.5), radius: 8)
                .cornerRadius(13)
            //maskedText(text: movie.title, image: image())
        }
        //.contextMenu{MovieContextMenu(movieId: self.movieId) }
    }
    
    private func maskedText(text: String, image: Image) -> some View {
        image
            .resizable()
            .frame(height: 16)
            .blur(radius: 10)
            .mask(Text(text))
            .overlay(content: {
                Text(movie.title).opacity(0.3)
            })
            .font(.oswald(size: 16, weight: .heavy))
            .padding(.top, -5)
            .lineLimit(1)
            .frame(width: PosterStyle.Size.medium.width())
    }
    
    private func image() -> Image {
        if let image = imageLoader.image {
            return Image(uiImage: image)
        }
        return Image(uiImage: UIImage())
    }
}

#if DEBUG
struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MoviePoster(movie: Movie.stubbedMovie)
                .aspectRatio(9/16, contentMode: .fit)
                .frame(width: 360)
        }
    }
}
#endif
