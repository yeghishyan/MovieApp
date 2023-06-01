//
//  Application.swift
//

import SwiftUI
import Firebase
import GoogleSignIn


@main
struct MainApplication: App {
    @StateObject var authModel = AuthenticationViewModel()

    init() {
        setupView()
        setupAuthentication()
    }
    
    var body: some Scene {
        WindowGroup {
            TabbarView()
                .environmentObject(authModel)
                .accentColor(.brown)
        }
    }
    
    private func setupView() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Oswald-Medium", size: 40 )!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "steam_foreground")!
        ]
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Oswald-Bold", size: 25)!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "steam_foreground")!
        ]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Oswald-Light", size: 16 )!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "steam_gold")!
        ], for: .normal)
        
        UIBarButtonItem.appearance().tintColor = UIColor(named: "steam_foreground")!
        
        UIWindow.appearance().tintColor = UIColor(named: "steam_tint")!
        UIWindow.appearance().backgroundColor = UIColor(named: "steam_background")!
    }
    
    private func setupAuthentication() {
        FirebaseApp.configure()
    }
}

