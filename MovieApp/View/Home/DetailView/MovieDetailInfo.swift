//
//  MovieDetailInfo.swift
//

import SwiftUI

struct MovieDetailInfo: View {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    private var glassMorphicField: some View {
        ZStack {
            GlassMorphicView(effect: .systemUltraThinMaterialDark) { view in
                view.saturationAmount = 10
                view.gaussianBlurValue = 10
            }
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.steam_theme.opacity(0.1),
                                 .clear],
                        startPoint: .top,
                        endPoint: .bottom)
                )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [.white.opacity(0.05),
                                 .white.opacity(0.25)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing),
                    lineWidth: 0)
        }
        //.overlay { content }
        .padding(.horizontal, 5)
    }
    
    private var gradient = LinearGradient(
        gradient: Gradient(colors: [.gray.lighter(), .steam_background]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    private var ratingSection: some View {
        HStack(alignment: .center, spacing: 5) {
            //RoundedBadge(text: "IMDB 7.0", color: .yellow)
            Button(action: {}, label: {
                HStack {
                    Image(systemName: "star.fill")
                        .imageScale(.small)
                    
                    Text("\(movie.vote_average)".prefix(3))
                        .font(.oswald(size: 14, weight: .medium))
                        .kerning(-0.9)
                    
                    Text("(\(movie.vote_count) votes)")
                        .font(.custom("SF Compact", size: 14))
                        .kerning(-0.9)
                }
            })
            .buttonStyle(GradientButtonStyle())
        }
    }
    
    private var titleSection: some View {
        VStack {
            Text(movie.title)
                .font(.oswald(style: .largeTitle, weight: .bold))
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
                .lineSpacing(0)
        }
    }
    
    private func genreSection(genres: [MovieGenre]) -> some View {
        HStack {
            ForEach(genres.prefix(3)) { genre in
                NavigationLink(destination: MovieGenreListView(genre: genre)) {
                    RoundedBadge(text: genre.name)
                }
            }
        }
    }
    
    private var overviewSection: some View {
        Text("\(movie.overview)")
            .font(.oswald(size: 15, weight: .medium))
            .kerning(-0.9)
            .foregroundColor(.secondary)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            ratingSection
            titleSection
            if let genres = movie.genres {
                genreSection(genres: genres)
            }
            overviewSection
        }
        .foregroundColor(.steam_gold)
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        //.blendMode(.overlay)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            glassMorphicField.opacity(0.8)
            content
        }
    }
}


#if DEBUG
struct MovieDetailInfo_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            MovieDetailInfo(movie: Movie.stubbedMovies[16])
        }
    }
}
#endif
