//
//  ContentView.swift
//

import SwiftUI


struct TabbarView: View {
    @State private var selectedTab: TabbarView.Tab = .home
    @ObservedObject private var appState: AppState = AppState()
    
    enum Tab: Int {
        case home
        case catalog
        case settings
        
        func name() -> String {
            switch self {
            case .home: return "Movies"
            case .catalog: return "Catalog"
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
            MovieHomeView()
                //.environmentObject(appState)
                .tabItem{
                    self.tabbarItem(.home, imageName: "popcorn.circle")
                }.tag(Tab.home)
            
            MovieCatalogView()
                .tabItem{
                    self.tabbarItem(.home, imageName: "film.circle")
                }.tag(Tab.catalog)
                
            
            SettingsView()
                .tabItem{
                    self.tabbarItem(.settings, imageName: "gearshape.circle")
                }.tag(Tab.settings)
        }
    }
}

#if DEBUG
struct Tabbar_Previews : PreviewProvider {
    static var previews: some View {
        TabbarView()
            .environmentObject(sampleState)
    }
}
#endif
