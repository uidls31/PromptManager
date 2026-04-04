import SwiftUI

struct AppCoordinatorView: View {
    
    
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        Group {
            switch coordinator.currentRoute {
            case .onboarding:
                OnboardingView()
            case .main:
                MainView()
            }
        }
        .environmentObject(coordinator)
    }
}

