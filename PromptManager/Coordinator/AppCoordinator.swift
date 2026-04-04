import Combine
import SwiftUI


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
    
    init(userDefaultsService: UserDefaultsServiceProtocol) {
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
        let promptVM: PromptViewModel
        if let existing = sharedPromptViewModel {
            promptVM = existing
        } else {
            promptVM = PromptViewModel(userDefaultsService: userDefaultsService)
            promptVM.onAddPrompt = { [weak self] in self?.presentSheet(.addPrompt) }
            promptVM.onPromptSelected = { [weak self] prompt in self?.push(.detail(prompt)) }
            sharedPromptViewModel = promptVM
        }
        
        let settingsVM: SettingsViewModel
        if let existing = sharedSettingsViewModel {
            settingsVM = existing
        } else {
            guard let termsURL = URL(string: "https://apple.com"),
                  let privacyURL = URL(string: "https://apple.com") else { fatalError("🛑")}
            settingsVM = SettingsViewModel(termsOfServiceURL: termsURL, privacyPolicyURL: privacyURL)
            sharedSettingsViewModel = settingsVM
        }
        
        return MainView(promptViewModel: promptVM, settingsViewModel: settingsVM)
    }
    
    func build(screen: AppScreen) -> some View {
        guard let viewModel = sharedPromptViewModel else { fatalError("🛑") }
        
        switch screen {
        case .detail(let prompt):
            return PromptDetailView(prompt: prompt, viewModel: viewModel)
        }
    }
    
    func build(sheet: AppSheet) -> some View {
        guard let viewModel = sharedPromptViewModel else { fatalError("🛑") }
        
        switch sheet {
        case .addPrompt:
            return AddPromptView(viewModel: viewModel)
        }
    }
    
}
