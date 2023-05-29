//
//  AppState.swift
//

import SwiftUI

final class AppState : ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    static var alwaysOriginalTitle: Bool = true
}

let sampleState: AppState = AppState()
