import Combine
import SwiftUI

enum AppRoute {
    case onboarding
    case main
}

class AppCoordinator: ObservableObject {
    
    let userDefaultsService: UserDefaultsServiceProtocol
    
    @Published var currentRoute: AppRoute = .onboarding
    
    init(userDefaultsService: UserDefaultsServiceProtocol = UserDefaultsService.shared) {
        self.userDefaultsService = userDefaultsService
        let hasCompletedOnboarding = userDefaultsService.bool(for: .hasCompletedOnboarding)
        currentRoute = hasCompletedOnboarding ? .main : .onboarding
    }
    
    func finishOnboarding() {
        userDefaultsService.set(true, for: .hasCompletedOnboarding)
        currentRoute = .main
    }
    
}

