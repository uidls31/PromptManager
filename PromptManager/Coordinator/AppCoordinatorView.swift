import SwiftUI

struct AppCoordinatorView: View {
    
    @StateObject private var coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        _coordinator = StateObject(wrappedValue: coordinator)
    }
    
    var body: some View {
        ZStack {
            if coordinator.currentState == .onboarding {
                coordinator.buildOnboarding()
                    .transition(.opacity)
            } else {
                coordinator.buildMain()
                    .transition(.opacity)
                    .sheet(item: $coordinator.activeSheet) { sheet in
                        switch sheet {
                        case .addPrompt:
                            AddPromptView()
                        }
                    }
            }
        }
        .animation(.easeInOut(duration: 0.8), value: coordinator.currentState)
        .environmentObject(coordinator)
    }
}

