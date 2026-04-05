import Foundation
import Combine

final class PromptViewModel: ObservableObject {
    
    @Published var prompts: [Prompt] = []
    
    var onAddPrompt: (() -> Void)?
    var onPromptSelected: ((Prompt) -> Void)?
    
    private let userDefaultsService: UserDefaultsServiceProtocol
    
    init(userDefaultsService: UserDefaultsServiceProtocol) {
        self.userDefaultsService = userDefaultsService
        loadPrompts()
    }
    
    private func loadPrompts() {
        if let data = userDefaultsService.data(for: .saveKeyPrompts),
           let decoded = try? JSONDecoder().decode([Prompt].self, from: data) {
            prompts = decoded
        }
    }
    
    func getUpToDatePrompt(for basePrompt: Prompt) -> Prompt {
        prompts.first(where: { $0.id == basePrompt.id }) ?? basePrompt
    }
    
    func filteredPromts(showOnlyFavorites: Bool) -> [Prompt] {
        showOnlyFavorites ? prompts.filter(\.isFavorite) : prompts
    }
    
    func addPrompt(title: String, content: String, category: Category) {
        let newPrompt = Prompt(id: UUID(),title: title, content: content, category: category, isFavorite: false, creationDate: Date())
        prompts.insert(newPrompt, at: 0)
        savePrompts()
    }
    
    func toggleFavorite(_ prompt: Prompt) {
        guard let index = prompts.firstIndex(where: { $0.id == prompt.id }) else { return }
        prompts[index].isFavorite.toggle()
        savePrompts()
    }
    
    func deletePrompt(_ prompt: Prompt) {
        prompts.removeAll(where: { $0.id == prompt.id })
        savePrompts()
    }
    
    private func savePrompts() {
        guard let data = try? JSONEncoder().encode(prompts) else { return }
        userDefaultsService.setData(data, for: .saveKeyPrompts)
        userDefaultsService.synchronize()
    }
    
    func didTapAddPrompt() {
        onAddPrompt?()
    }
    
    func didSelectPrompt(_ prompt: Prompt) {
        onPromptSelected?(prompt)
    }
}
