//
//  MovieImagesView.swift
//

import SwiftUI

struct MovieImagesView: View {
    @StateObject private var imagesViewModel = MovieImagesViewModel()
    @ObservedObject private var imageLoader: ImageLoader
    
    let movie: Movie
    
    var body: some View {
        VStack {
            if let images = imagesViewModel.images?.backdrops {
                VStack(alignment: .leading) {
                    Text("Movie images")
                        .font(.oswald(size: 15)).bold()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .top, spacing: 10) {
                            ForEach(images) { image in
                                
                            }
                        }
                    }
                }
            }
        }
        .task {
            Task { await imagesViewModel.fetchMovieImages(movieId: movie.id) }
        }
        .overlay {
            DataLoadingView(
                phase: imagesViewModel.phase,
                retryAction: {})
        }
    }
}
