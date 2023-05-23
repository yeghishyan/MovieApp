//
//  NavigationBackButton.swift
//  MovieApp
//
//  Created by valod on 23.05.23.
//

import SwiftUI

struct NavigationBackButton: View {
    var dismiss: DismissAction
    
    var body: some View {
        Button {
            DispatchQueue.main.async {
                dismiss()
            }
        } label: {
            ZStack {
                GlassMorphicView(effect: .systemUltraThinMaterialDark) { view in
                    
                }.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                Image(systemName: "chevron.backward.circle")
                    .foregroundColor(.black)
            }
        }
    }
}

struct NavigationFavoriteButton: View {
    @Binding var isFavorite: Bool
    
    var body: some View {
        Button {
            DispatchQueue.main.async {
                isFavorite.toggle()
            }
        } label: {
            ZStack {
                GlassMorphicView(effect: .systemUltraThinMaterialDark) { view in }
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                Image(systemName: "bookmark.circle")
                    .foregroundColor(isFavorite ? .yellow : .black)
            }
        }
    }
}
