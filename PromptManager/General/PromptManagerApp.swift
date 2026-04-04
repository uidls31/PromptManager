import SwiftUI

@main
struct PromptManagerApp: App {
    
    let userDefaultsService: UserDefaultsServiceProtocol = UserDefaultsService()
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: AppCoordinator(userDefaultsService: userDefaultsService))
        }
    }
}
