//
//  MovieSection.swift
//

import Foundation
import SwiftUI

struct MovieSection: Identifiable {
    let id = UUID()
    
    let movies: [Movie]
    let endpoint: MovieSectionEndpoint
    var title: String { endpoint.title() }
}

extension MovieSection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MovieSection, rhs: MovieSection) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MovieSection {
    var alignment: Axis.Set {
        if self.endpoint == .topRated {
            return .vertical
        }
        else {
            return .horizontal
        }
    }
}
