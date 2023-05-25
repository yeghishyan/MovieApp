//
//  MovieDetailInfo.swift
//

import SwiftUI
import Foundation

struct MovieDetailInfo: View {
   private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    private var glassMorphicField: some View {
        ZStack {
            GlassMorphicView(effect: .systemUltraThinMaterialDark) { view in
                view.saturationAmount = 10
                view.gaussianBlurValue = 20
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
                        colors: [.steam_gold.opacity(0.25),
                                 .steam_foreground.opacity(0.45)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing),
                    lineWidth: 3)
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
        HStack {
            Button(action: {}, label: {
                HStack(alignment: .center, spacing: 2) {
                    Image(systemName: "star.fill")
                        .imageScale(.small)
                    
                    Text("\(movie.vote_average)".prefix(3))
                    
                    Text(" (\(movie.vote_count) votes)")
                }
            })
            
            Spacer()
            
            Button(action: {}, label: {
                HStack(spacing: 2) {
                    Image(systemName: "clock")
                        .imageScale(.small)
                        
                    Text(movie.durationText)
                }.padding(.horizontal, -5)
            })
        }
        .font(.oswald(size: 13, weight: .heavy))
        .kerning(-0.9)
        .frame(height: 25)
        .buttonStyle(GradientButtonStyle(
            colors: [.steam_theme.opacity(0.2), .steam_foreground.opacity(0.3)],
            cornerRadius: 5)
        )
        .blendMode(.overlay)
        .opacity(0.9)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(movie.title)
                .fixedSize(horizontal: false, vertical: true)
                .font(.oswald(style: .largeTitle, weight: .bold))
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
                .lineSpacing(-1)
        }.padding(.top, -10)
    }
    
    private var genreSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let genres = movie.genres, !genres.isEmpty {
                Divider()
                HStack(alignment: .center, spacing: 10) {
                    
                    Text(movie.releaseDate, format: Date.FormatStyle().month().year())
                        .font(.oswald(size: 15, weight: .bold))
                        .padding(.leading, 2)
                    
                    Divider()
                    //ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .center) {
                            ForEach(genres.prefix(3)) { genre in
                                NavigationLink(
                                    destination: MovieDiscoverView(
                                        title: genre.name,
                                        param: .genre,
                                        value: "\(genre.id)"
                                    )
                                ) {
                                    RoundedBadge(text: genre.name)
                                }
                            }
                        }
                    //}
                }
                .frame(height: 30)
                Divider()
            }
        }
    }
    
    private var overviewSection: some View {
        Text(movie.overview)
            .font(.oswald(size: 15, weight: .medium))
            .foregroundColor(.secondary)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 20) {
            ratingSection
            titleSection
            genreSection
            overviewSection
            MovieCreditView(movie: movie)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            glassMorphicField
                .opacity(0.98)
            content
                .padding(.horizontal, 10)
                .padding(.trailing, 10)
        }
    }
}


#if DEBUG
struct MovieDetailInfo_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            MovieDetailInfo(movie: Movie.stubbedMovies[12])
        }
    }
}
#endif
