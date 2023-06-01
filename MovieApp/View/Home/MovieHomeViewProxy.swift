//
//  MovieHomeViewProxy.swift
//  

import SwiftUI

struct MovieHomeViewProxy: View {
    private var size: CGSize
    private let movies: [Movie]
    
    init(movies: [Movie], size: CGSize) {
        self.movies = movies
        self.size = size
    }
    
    @ViewBuilder
    private func mainSection() -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Upcoming")
                    .font(.oswald(size: 23))
                
                NavigationLink(destination: MovieListView(movies: movies)) {
                        Spacer()
                        Text("See all")
                        Image(systemName: "chevron.right")
                }.font(.oswald(size: 15))
            }
            .padding(.horizontal, 25)
            .foregroundColor(.primary)
            MovieListView(movies: Array(movies.prefix(3)))
        }
    }
    
    
    func getScale(proxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = size.width/3
        let frame = proxy.frame(in: CoordinateSpace.global)
        
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 10
        
        let diffFromCenter = abs(midPoint - frame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter > deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 900
        }
        
        return scale != 0 ? scale : 1
    }
    
    @ViewBuilder
    private func headerSection() -> some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(movies) { movie in
                        NavigationLink(
                            destination: MovieDetailView(movieId: movie.id)
                        ) {
                            GeometryReader{ geometry in
                                let scale = getScale(proxy: geometry)
                                
                                MovieCardView(movieId: movie.id, size: .custom(150))
                                    .id(movie.id)
                                    .shadow(radius: 13, y: 10)
                                    .scaleEffect(CGSize(width: scale, height: scale))
                            }
                        }
                    }
                    .onAppear {
                        reader.scrollTo(movies[1].id, anchor: .center)
                    }
                    .frame(width: 150)
                    .frame(height: size.height/3 + 30) // +30 padding
                }
            }
        }
        .padding(.vertical, 10)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                headerSection()
                mainSection()
            }
        }
        .coordinateSpace(name: "SCROLL")
    }
    
    private func index(_ of: Movie) -> Int {
        return movies.firstIndex(of: of) ?? 0
    }
}

#if DEBUG
struct MovieHomeProxy_Previews : PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}
#endif

