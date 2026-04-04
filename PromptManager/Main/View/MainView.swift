import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = PromptViewModel()

    var body: some View {
        TabView {
            PromptListView(showOnlyFavorites: false)
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }
            
            PromptListView(showOnlyFavorites: true)
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .environmentObject(viewModel)
        
    }
}

#Preview {
    MainView()
}
