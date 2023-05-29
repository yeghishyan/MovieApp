//
//  MovieImageView.swift
//

import SwiftUI

struct MovieImageView: View {
    @ObservedObject private var imageLoader: ImageLoader
    
    init(imagePath: String?) {
        self.imageLoader = ImageLoader(path: imagePath, quality: .sd)
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
        .fixedSize(size: .medium)
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
