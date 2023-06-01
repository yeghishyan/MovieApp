//
//  MovieHeaderImage.swift
//

import SwiftUI

struct MovieHeaderImage: View {
    @ObservedObject private var imageLoader: ImageLoader
    @State private var offset: CGFloat = 0
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isPortrait: Bool { verticalSizeClass == .regular }
    private var imageHeight: CGFloat = 700
    
    init(imagePath: String?, quality: ImageLoader.Quality = .original) {
        self.imageLoader = ImageLoader(path: imagePath, quality: quality)
        self.imageLoader.loadImage()
    }
    
    @ViewBuilder
    private var image: some View {
        ZStack {
            if let image = imageLoader.image {
                if isPortrait {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    GeometryReader { geometry in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height,
                                   alignment: .top)
                    }
                }
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .shimmering()
            }
        }
        .transition(.opacity.animation(Animation.default.speed(0.5)))
    }
    
    var body: some View {
        ZStack {
            image
        }
    }
}

#if DEBUG
struct MovieDetailImage_Preview: PreviewProvider {
    static var previews: some View {
        ScrollView {
            MovieHeaderImage(imagePath: Movie.stubbedMovies[15].poster_path)
        }.ignoresSafeArea()
    }
}
#endif
