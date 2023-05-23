//
//  MovieDetailImage.swift
//

import SwiftUI

struct MovieDetailImage: View {
    @ObservedObject private var imageLoader: ImageLoader
    
    init(imagePath: String?) {
        self.imageLoader = ImageLoader(imagePath: imagePath, size: .hd)
    }
    
    private var image: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Rectangle()
                    .foregroundColor(.gray)
            }
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
                .overlay{
                    gradient
                    gradient.offset(y: 120)
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct MovieDetailImage_Preview: PreviewProvider {
    static var previews: some View {
        MovieDetailImage(imagePath: Movie.stubbedMovies[2].poster_path)
    }
}
#endif
