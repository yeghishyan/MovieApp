//
//  MovieDetailImage.swift
//

import SwiftUI

struct MovieDetailImage: View {
    @ObservedObject private var imageLoader: ImageLoader
    
    init(imagePath: String) {
        self.imageLoader = ImageLoader(imagePath: imagePath, size: .hd)
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
    
    private var gradient: some View {
        LinearGradient(
            stops: [.init(color: .steam_theme, location: 0),
                    .init(color: .clear, location: 1)],
            startPoint: .top, endPoint: .bottom)
    }
    
    var body: some View {
        ZStack {
            image
                .overlay{
                    gradient
                    gradient.offset(y: 120)
                }
        }
    }
}

#if DEBUG
struct MovieDetailImage_Preview: PreviewProvider {
    static var previews: some View {
        MovieDetailImage(imagePath: Movie.stubbedMovies[0].poster_path)
    }
}
#endif
