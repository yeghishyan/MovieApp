//
//  MovieDetailImage.swift
//

import SwiftUI

struct MovieDetailImage: View {
    @ObservedObject private var imageLoader: ImageLoader
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isPortrait: Bool { verticalSizeClass == .regular }
    
    init(imagePath: String?) {
        self.imageLoader = ImageLoader(imagePath: imagePath, size: .hd)
    }
    
    private var image: some View {
        ZStack {
            if let image = imageLoader.image {
                if isPortrait {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.all)
                } else {
                    GeometryReader { geometry in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                            .frame(maxWidth: geometry.size.width,
                                   maxHeight: geometry.size.height,
                                   alignment: .top)
                    }
                }
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
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct MovieDetailImage_Preview: PreviewProvider {
    static var previews: some View {
        @Environment(\.verticalSizeClass) var verticalSizeClass
        var isPortrait: Bool { verticalSizeClass == .regular }
        let id = 16
        
        MovieDetailImage(
            imagePath: (!isPortrait ? Movie.stubbedMovies[id].poster_path : Movie.stubbedMovies[id].backdrop_path))
    }
}
#endif
