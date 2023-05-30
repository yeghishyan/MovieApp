//
//  MovieImageView.swift
//

import SwiftUI

struct MovieImageView: View {
    @ObservedObject private var imageLoader: ImageLoader
    private var size: ImageStyle.Size
    private var isPoster: Bool
    
    init(imagePath: String?, size: ImageStyle.Size = .medium, isPoster: Bool = true) {
        self.imageLoader = ImageLoader(path: imagePath, quality: .sd)
        self.size = size
        self.isPoster = isPoster
    }
    
    private var image: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
        .fixedSize(size: size, isPoster: isPoster)
    }
    
    var body: some View {
        image
    }
}

#if DEBUG
struct MovieImage_Preview: PreviewProvider {
    static var previews: some View {
        MovieImageView(imagePath: Movie.stubbedMovies[0].poster_path)
    }
}
#endif
