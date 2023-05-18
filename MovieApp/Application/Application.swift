//
//  Application.swift
//

import SwiftUI

@main
struct MainApplication: App {
    init() {
        setupView()
    }
    
    var body: some Scene {
        WindowGroup {
            //StoreProvider(store: store) {
            TabbarView().accentColor(.brown)
            //}
        }
    }
    
    private func setupView() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Oswald-Medium", size: 40 )!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "steam_foreground")!]
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Oswald-Regular", size: 18 )!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "steam_foreground")!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Oswald-Light", size: 16 )!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "steam_gold")!], for: .normal)
        
        UIWindow.appearance().tintColor = UIColor(named: "steam_tint")!
        UIWindow.appearance().backgroundColor = UIColor(named: "steam_background")!
    }
}

