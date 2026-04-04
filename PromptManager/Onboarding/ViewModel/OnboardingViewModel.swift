import Foundation
import Combine

final class OnboardingViewModel: ObservableObject {
    
    @Published var selection: OnboardingPage.ID?
    
    var onFinishOnboarding: (() -> Void)?
    
    var lastPageID: OnboardingPage.ID? { pages.last?.id }
    
    let pages: [OnboardingPage] = [
        .init(
            symbol: "sparkles.rectangle.stack",
            title: "Save the best prompts",
            description: "Add successful AI prompts to a collection so you can quickly reproduce results without rewriting everything."
            
        ),
        .init(
            symbol: "wand.and.stars",
            title: "Improve responses gradually",
            description: "Versions, notes, and small edits help refine a prompt to perfection—and always keep a reliable version at hand."
        ),
        .init(
            symbol: "tray.and.arrow.down.fill",
            title: "One-tap access",
            description: "Store prompts in a structured way and use them when needed-for work, study, and creativity."
        ),
    ]
    
    init() {
        selection = pages.first?.id
    }
    
    func nextPage() {
        guard let current = selection,
              let currentIndex = pages.firstIndex(where: { $0.id == current }) else { return }
        
        if currentIndex < pages.count - 1 {
            selection = pages[currentIndex + 1].id
        } else {
            onFinishOnboarding?()
        }
    }
}
