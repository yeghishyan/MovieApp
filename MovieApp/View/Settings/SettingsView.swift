//
//  SettingsView.swift
//

import SwiftUI

struct SettingsView : View {
    @State var alwaysOriginalTitle: Bool = false
    
    @ViewBuilder
    func debugInfoView(title: String, info: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(info).font(.body).foregroundColor(.secondary)
        }
    }
    
    var body: some View {
        NavigationSplitView(
            sidebar:{
                Form {
                    Section(header: Text("Main"), content: {
                        Toggle(isOn: $alwaysOriginalTitle) {
                            Text("Always show original title")
                        }
                    }
                    )
                    Section(header: Text("App data"), content: {
                        Text("Export my data")
                        Text("Backup to iCloud")
                        Text("Restore from iCloud")
                        Text("Reset application data").foregroundColor(.red)
                    })
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
            },
            detail: {
                
            })
    }
}

#if DEBUG
struct Settings_Previw : PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
#endif
