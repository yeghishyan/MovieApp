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
            
        }
    }
    
    func tabbarItem(tab: Tab, imageName: String) -> some View {
        VStack {
            if selectedTab == tab {
                imageName = imageName + ".fill"
            }
            
            Image(imageName)
                .imageScale(.large)
            Text(tab.name())
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MovieHomeView().tabItem{
                self.tabbarItem(text: "Movies", imageName: "")
            }.tag(Tab.movies)
            MovieHomeView().tabItem{
                self.tabbarItem(text: "Discover", imageName: "film-reel")
            }.tag(Tab.discover)
            SettingsView().tabItem{
                self.tabbarItem(text: "Settings", imageName: "settings-button")
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
