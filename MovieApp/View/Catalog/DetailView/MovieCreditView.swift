//
//  MovieCreditView.swift
//

import SwiftUI

struct MovieCreditView: View {
    @State private var isLoading: Bool = true
    let movie: Movie
    
    @ViewBuilder
    private func crewView(cast: [MovieCast]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .center, spacing: 0) {
                ForEach(cast) { character in
                    NavigationLink(
                        destination: MovieDiscoverView(
                            title: character.name,
                            param: .people,
                            value: "\(character.id)"
                        )
                    ) {
                        VStack(alignment: .center, spacing: 0) {
                            if let imagePath = character.profile_path {
                                MovieCastImage(imagePath: imagePath)
                                    .padding(.horizontal, 5)
                                
                                Text(character.name)
                                    .frame(maxWidth: 70)
                                Text(character.character)
                                    .frame(maxWidth: 70)
                            }
                        }
                        .foregroundColor(.secondary)
                        .lineLimit(1).truncationMode(.tail)
                        .font(.oswald(size: 13))
                    }
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let directors = movie.directors, !directors.isEmpty {
                HStack(alignment: .top) {
                    Text("Directors: ")
                        .bold()
                    ForEach(directors.prefix(2)) { director in
                        NavigationLink(destination: MovieDiscoverView(
                            title: director.name,
                            param: .people,
                            value: "\(director.id)")
                        ) {
                            Text(director.name)
                        }
                    }
                }
                .font(.oswald(size: 15))
                
            }
            if let producers = movie.producers, !producers.isEmpty {
                HStack(alignment: .top) {
                    Text("Producers: ")
                        .bold()
                    ForEach(producers.prefix(2)) { producer in
                        NavigationLink(destination: MovieDiscoverView(
                            title: producer.name,
                            param: .people,
                            value: "\(producer.id)")
                        ) {
                            Text(producer.name)
                        }
                    }
                }.font(.oswald(size: 15))
            }
            
            if let cast = movie.credits?.cast, !cast.isEmpty {
                Divider()
                VStack(alignment: .leading) {
                    Text("Starring")
                        .font(.oswald(size: 15)).bold()
                    crewView(cast: cast)
                }
            }
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .shimmering(active: isLoading)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isLoading.toggle()
            }
        }
    }
    
}

#if DEBUG
struct MovieCredit_Preview: PreviewProvider {
    static var previews: some View {
        MovieCreditView(movie: Movie.stubbedMovies[16])
    }
}
#endif
