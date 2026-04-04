import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = PromptViewModel()

    var body: some View {
        TabView {
            PromptListView(viewModel: viewModel, showOnlyFavorites: false)
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }
            
            PromptListView(viewModel: viewModel, showOnlyFavorites: true)
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        
    }
}

#Preview {
    MainView()
}
