import Combine
import SwiftUI
import SwiftData


class AppCoordinator: ObservableObject {
    
    let userDefaultsService: UserDefaultsServiceProtocol
    let modelContainer: ModelContainer
    
    @Published var currentState: AppState
    @Published var activeSheet: AppSheet?
    
    @Published var selectedTab: MainTab = .library
    @Published var libraryPath = NavigationPath()
    @Published var favoritesPath = NavigationPath()
    @Published var settingsPath = NavigationPath()
    
    private lazy var promptViewModel: PromptViewModel = {
        let vm = PromptViewModel(modelContainer: modelContainer)
        vm.onAddPrompt = { [weak self] in self?.presentSheet(.addPrompt) }
        vm.onPromptSelected = { [weak self] prompt in self?.push(.detail(prompt)) }
        return vm
    }()
    
    private lazy var settingsViewModel: SettingsViewModel = {
        guard let termsURL = URL(string: "https://apple.com"),
              let privacyURL = URL(string: "https://apple.com") else { fatalError("🛑") }
        return SettingsViewModel(termsOfServiceURL: termsURL, privacyPolicyURL: privacyURL)
    }()
    
    private lazy var onboardingViewModel: OnboardingViewModel = {
        let vm = OnboardingViewModel()
        vm.onFinishOnboarding = { [weak self] in
            self?.finishOnboarding()
        }
        return vm
    }()
    
    init(userDefaultsService: UserDefaultsServiceProtocol,
         modelContainer: ModelContainer) {
        self.userDefaultsService = userDefaultsService
        self.modelContainer = modelContainer
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
        return OnboardingView(viewModel: onboardingViewModel)
    }
    
    func buildMain() -> some View {
        return MainView(promptViewModel: self.promptViewModel, settingsViewModel: self.settingsViewModel)
    }
    
    func build(screen: AppScreen) -> some View {
        switch screen {
        case .detail(let prompt):
            return PromptDetailView(prompt: prompt, viewModel: self.promptViewModel)
        }
    }
    
    func build(sheet: AppSheet) -> some View {
        switch sheet {
        case .addPrompt:
            return AddPromptView(viewModel: self.promptViewModel)
        }
    }
    
}
