import Foundation
import Combine

final class PromptViewModel: ObservableObject {

    @Published var prompts: [Prompt] = []

    init() {
        if let data = UserDefaultsService.shared.data(for: .saveKeyPrompts),
           let decoded = try? JSONDecoder().decode([Prompt].self, from: data) {
            prompts = decoded
        }
    }

    func filteredPromts(showOnlyFavorites: Bool) -> [Prompt] {
        showOnlyFavorites ? prompts.filter(\.isFavorite) : prompts
    }

    func addPrompt(title: String, content: String, category: Category) {
        let newPrompt = Prompt(title: title, content: content, category: category)
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
        UserDefaultsService.shared.setData(data, for: .saveKeyPrompts)
    }
}
