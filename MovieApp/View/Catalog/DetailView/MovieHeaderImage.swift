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
    }
    
    @ViewBuilder
    private var image: some View {
        ZStack {
            if let image = imageLoader.image {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    if isPortrait {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rect.width, height: rect.height)
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
                }.transition(.opacity.animation(Animation.default.speed(0.5)))
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .shimmering()
            }
        }
        .onAppear {
            self.imageLoader.loadImage()
        }
    }
    
    private var gradient: some View {
        LinearGradient(
            stops: [.init(color: .clear, location: 0),
                    .init(color: .steam_theme, location: 1)],
            startPoint: .center,
            endPoint: .bottom)
    }
    
    var body: some View {
        ZStack {
            image
            gradient
            gradient.offset(y: 120)
        }
        .background {
            ScrollDetector { offset in
                self.offset = offset
            } onDraggingEnd: { offset, velocity in
            }
        }
        .frame(height: offset > 0 ? imageHeight : imageHeight - offset, alignment: .bottom)
        .offset(y: offset)
        .edgesIgnoringSafeArea(.all)
        .transition(.opacity.animation(Animation.default.speed(0.5)))
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
