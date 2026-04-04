import Foundation

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
