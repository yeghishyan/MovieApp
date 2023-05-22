//
//  ContentView.swift
//

import SwiftUI

struct TabbarView: View {
    @State var selectedTab = Tab.movies
    
    enum Tab: Int {
        case movies
        case discover
        case settings
        
        func name() -> String {
            switch self {
            case .movies: return "Movies"
            case .discover: return "Discover"
            case .settings: return "Settings"
            }
        }
    }
    
    func tabbarItem(_ tab: Tab, imageName: String) -> some View {
        VStack {
            Image(systemName: selectedTab == tab ? imageName + ".fill" : imageName)
                .imageScale(.large)
                .foregroundColor(selectedTab == tab ? .red : .steam_foreground)
            Text(tab.name())
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MovieHomeView().tabItem{
                self.tabbarItem(.movies, imageName: "film.circle")
            }.tag(Tab.movies)
            MovieHomeView().tabItem{
                self.tabbarItem(.discover, imageName: "popcorn.circle")
            }.tag(Tab.discover)
            SettingsView().tabItem{
                self.tabbarItem(.settings, imageName: "gearshape.circle")
            }.tag(Tab.settings)
        }
    }
}

#if DEBUG
struct Tabbar_Previews : PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
#endif
