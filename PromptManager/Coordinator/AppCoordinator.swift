import Combine
import SwiftUI

enum AppState {
    case onboarding, main
}

enum AppScreen: Hashable {
    case detail(Prompt)
}

enum AppSheet: String, Identifiable {
    case addPrompt
    var id: String {
        self.rawValue
    }
}

enum MainTab: Hashable {
    case library, favorites, settings
}

class AppCoordinator: ObservableObject {
    
    let userDefaultsService: UserDefaultsServiceProtocol
    
    @Published var currentState: AppState
    @Published var activeSheet: AppSheet?
    
    @Published var selectedTab: MainTab = .library
    @Published var libraryPath = NavigationPath()
    @Published var favoritesPath = NavigationPath()
    @Published var settingsPath = NavigationPath()
    
    private var sharedPromptViewModel: PromptViewModel?
    private var sharedSettingsViewModel: SettingsViewModel?
    
    init(userDefaultsService: UserDefaultsServiceProtocol = UserDefaultsService.shared) {
        self.userDefaultsService = userDefaultsService
        let hasCompletedOnboarding = userDefaultsService.bool(for: .hasCompletedOnboarding)
        currentState = hasCompletedOnboarding ? .main : .onboarding
    }
    
    func finishOnboarding() {
        userDefaultsService.setBool(true, for: .hasCompletedOnboarding)
        currentState = .main
    }
    
    func push(_ screen: AppScreen) {
        switch selectedTab {
        case .library:
            libraryPath.append(screen)
        case .favorites:
            favoritesPath.append(screen)
        case .settings:
            settingsPath.append(screen)
        }
    }
    
    func pop() {
        switch selectedTab {
        case .library:
            if !libraryPath.isEmpty { libraryPath.removeLast() }
        case .favorites:
            if !favoritesPath.isEmpty { favoritesPath.removeLast() }
        case .settings:
            if !settingsPath.isEmpty { settingsPath.removeLast() }
        }
    }
    
    func presentSheet(_ sheet: AppSheet) {
        activeSheet = sheet
    }
    
    func dismissSheet() {
        activeSheet = nil
    }
    
}

extension AppCoordinator {
    
    func buildOnboarding() -> some View {
        let viewModel = OnboardingViewModel()
        
        viewModel.onFinishOnboarding = { [weak self] in
            self?.finishOnboarding()
        }
        return OnboardingView(viewModel: viewModel)
    }
    
    func buildMain() -> some View {
        if sharedPromptViewModel == nil {
            let viewModel = PromptViewModel(userDefaultsService: userDefaultsService)
            
            viewModel.onAddPrompt = { [weak self] in
                self?.presentSheet(.addPrompt)
            }
            
            viewModel.onPromptSelected = { [weak self] prompt in
                self?.push(.detail(prompt))
            }
            sharedPromptViewModel = viewModel
            
        }
        
        if sharedSettingsViewModel == nil {
            guard let termsURL = URL(string: "https://apple.com"),
                  let privacyURL = URL(string: "https://apple.com") else {
                fatalError("🛑") }
            
            sharedSettingsViewModel = SettingsViewModel(termsOfServiceURL: termsURL, privacyPolicyURL: privacyURL)
        }
        return MainView(promptViewModel: sharedPromptViewModel!, settingsViewModel: sharedSettingsViewModel!)
    }
    
    func build(screen: AppScreen) -> some View {
        switch screen {
        case .detail(let prompt):
            return PromptDetailView(prompt: prompt, viewModel: sharedPromptViewModel ?? PromptViewModel(userDefaultsService: userDefaultsService))
        }
    }
    
    func build(sheet: AppSheet) -> some View {
        switch sheet {
        case .addPrompt:
            return AddPromptView(viewModel: sharedPromptViewModel ?? PromptViewModel(userDefaultsService: userDefaultsService))
        }
    }
    
}
