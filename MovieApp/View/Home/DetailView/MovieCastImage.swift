//
//  MovieCastImageView.swift
//

import SwiftUI

struct MovieCastImage: View {
    @ObservedObject private var imageLoader: ImageLoader
    private let height: CGFloat
    
    init(imagePath: String?, height: CGFloat = 100) {
        self.imageLoader = ImageLoader(path: imagePath, size: .ld)
        self.height = height
    }
    
    var body: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(height: height)
            } else {
                Circle()
                    .foregroundColor(.gray)
            }
        }
    }
}

#if DEBUG
struct MovieCastImage_Preview: PreviewProvider {
    static var previews: some View {
        MovieCastImage(imagePath: Movie.stubbedMovies[0].poster_path)
    }
}
#endif

