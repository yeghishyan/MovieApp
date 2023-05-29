//
//  MovieThumbnailView.swift
//

import SwiftUI

fileprivate let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy"
    return formatter
}()

struct MovieCellView: View {
    @ObservedObject var imageLoader: ImageLoader
    private let movie: Movie
    private let size: ImageStyle.Size
    
    init(movie: Movie, quality: ImageLoader.Quality = .sd, size: ImageStyle.Size = .small) {
        self.movie = movie
        self.size = size
        imageLoader = ImageLoader(path: movie.poster_path, quality: quality)
        //ImageLoader(path: movie.poster_path, quality: quality)
    }
    
    private var titleSection: some View {
        ZStack {
            Text(movie.userTitle)
        }
        .lineLimit(2)
        .multilineTextAlignment(.leading)
        .font(.oswald(size: 23, weight: .heavy))
    }
    
    private var ratingSection: some View {
        HStack(alignment: .center, spacing: 15) {
            CircleRating(score: Int(movie.vote_average * 10))
            //Text(formatter.string(from: movie.releaseDate ?? Date()))
            Text(movie.releaseDate, format: Date.FormatStyle().day().month().year())
                .lineLimit(1)
                .font(.oswald(size: 15, weight: .bold))
        }
        .foregroundColor(.steam_gold)
        .padding(.leading, 5)
    }
    
    private var overviewSection: some View {
        VStack(alignment: .leading) {
            Text(movie.overview)
                .truncationMode(.tail)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .foregroundColor(.secondary)
                .font(.oswald(size: 15))
        }
    }
                
    private var image: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .transition(.opacity.animation(Animation.default.speed(0.5)))
            } else {
                Rectangle()
                    .fill(.gray)
                    .shimmering()
            }
        }
        .onAppear {
            self.imageLoader.loadImage()
        }
        .fixedSize(size: size)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            image
                .shadow(radius: 5)
                .cornerRadius(9)
            ZStack {
                VStack(alignment: .leading) {
                    titleSection
                    ratingSection
                    overviewSection
                }
                .redacted(reason: imageLoader.image == nil ? .placeholder : [])
                .shimmering(active: imageLoader.image == nil)
            }
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 10)
        //.contextMenu{MovieContextMenu(movieId: self.movieId) }
    }
}

#if DEBUG
struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieCellView(movie: Movie.stubbedMovies[13])
        }
    }
}
#endif
