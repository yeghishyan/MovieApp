//
//  MovieCastImageView.swift
//

import SwiftUI

struct MovieCastImage: View {
    @ObservedObject private var imageLoader: ImageLoader
    private let sideSize: CGFloat
    
    init(imagePath: String?, sideSize: CGFloat = 70) {
        self.imageLoader = ImageLoaderCache.shared.loaderFor(path: imagePath, quality: .ld)
        //ImageLoader(path: imagePath, quality: .ld)
        self.sideSize = sideSize
    }
    
    private var image: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.blue)
            }
        }
    }
    
    var body: some View {
        Circle()
            .overlay(GeometryReader {
                let side = sqrt($0.size.width  * 2 * $0.size.width / 2)
                VStack {
                    Rectangle().foregroundColor(.clear)
                        .frame(width: side, height: side)
                        .overlay(
                            image
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            })
            .frame(width: sideSize, height: sideSize)
            .clipShape(Circle())
    }
}

#if DEBUG
struct MovieCastImage_Preview: PreviewProvider {
    static var previews: some View {
        MovieCastImage(imagePath: Movie.stubbedMovies[0].poster_path)
    }
}
#endif

