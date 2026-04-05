import SwiftUI
import SwiftData

struct MainView: View {
    
    @ObservedObject var promptViewModel: PromptViewModel
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    @EnvironmentObject private var coordinator: AppCoordinator
    

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            
            NavigationStack(path: $coordinator.libraryPath) {
                PromptListView(viewModel: promptViewModel, showOnlyFavorites: false)
                    .navigationDestination(for: AppScreen.self) { screen in
                        coordinator.build(screen: screen)
                    }
            }
            .tabItem {
                Label("Prompts", systemImage: "folder")
            }
            .tag(MainTab.library)
            
            NavigationStack(path: $coordinator.favoritesPath) {
                PromptListView(viewModel: promptViewModel, showOnlyFavorites: true)
                    .navigationDestination(for: AppScreen.self) { screen in
                        coordinator.build(screen: screen)
                    }
            }
            .tabItem {
                Label("Favorites", systemImage: "star.fill")
            }
            .tag(MainTab.favorites)
            
            NavigationStack(path: $coordinator.settingsPath) {
                SettingsView(viewModel: settingsViewModel)
                    .navigationDestination(for: AppScreen.self) { screen in
                        coordinator.build(screen: screen)
                    }
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
            .tag(MainTab.settings)
        }
        
    }
}

