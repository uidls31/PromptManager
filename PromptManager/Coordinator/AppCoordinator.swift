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

class AppCoordinator: ObservableObject {
    
    let userDefaultsService: UserDefaultsServiceProtocol
    
    @Published var currentState: AppState
    @Published var path = NavigationPath()
    @Published var activeSheet: AppSheet?
    
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
        path.append(screen)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
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
        MainView()
    }
    
    
}
