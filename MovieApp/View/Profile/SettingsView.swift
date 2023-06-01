//
//  SettingsView.swift
//

import SwiftUI

struct SettingsView : View {
    @State private var alwaysOriginalTitle: Bool = false
    @State private var loginPresented: Bool = false
    
    @ViewBuilder
    func debugInfoView(title: String, info: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(info).font(.body).foregroundColor(.secondary)
        }
    }
    
    private var loginButton: some View {
        Button(action: {
            loginPresented = true
        }) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .imageScale(.large)
                .frame(width: 25, height: 25, alignment: .center)
        }
        .frame(width: 44, height: 44, alignment: .center)
        .tint(Color.steam_foreground)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Main")) {
                    Toggle(isOn: $alwaysOriginalTitle) {
                        Text("Always show original title")
                    }
                }
                
                Section(header: Text("App data")) {
                    Text("Export my data")
                    Text("Backup to iCloud")
                    Text("Restore from iCloud")
                    Text("Reset application data").foregroundColor(.red)
                }
                
                Section(header: Text("Debug info")) {
                    debugInfoView(title: "Movies in state", info: "movies count")
                    debugInfoView(title: "Archived state size", info: "chace size")
                }
            }
            .onAppear{
                self.alwaysOriginalTitle = AppState.alwaysOriginalTitle
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { loginButton }
            }
            .sheet(isPresented: $loginPresented, content: {
                LoginView()
            })
        }
    }
}

#if DEBUG
struct Settings_Previw : PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
#endif
