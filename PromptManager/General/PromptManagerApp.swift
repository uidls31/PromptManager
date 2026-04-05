import SwiftUI
import SwiftData

@main
struct PromptManagerApp: App {
    
    private let userDefaultsService: UserDefaultsServiceProtocol = UserDefaultsService()
    private let modelContainer = try! ModelContainer(for: PromptRecord.self)
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: AppCoordinator(userDefaultsService: userDefaultsService, modelContainer: modelContainer))
        }
        .modelContainer(modelContainer)
    }
}
