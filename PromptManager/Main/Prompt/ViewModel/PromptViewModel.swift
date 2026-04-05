import Foundation
import Combine
import SwiftData

final class PromptViewModel: ObservableObject {
    
    @Published var prompts: [Prompt] = []
    
    var onAddPrompt: (() -> Void)?
    var onPromptSelected: ((Prompt) -> Void)?
    
    private let modelContext: ModelContext
    
    init(modelContainer: ModelContainer) {
        self.modelContext = modelContainer.mainContext
        loadPrompts()
    }
    
    private func loadPrompts() {
        let descriptor = FetchDescriptor<PromptRecord>(
            sortBy: [SortDescriptor(\.creationDate, order: .reverse)]
        )
        prompts = (try? modelContext.fetch(descriptor).map(\.prompt)) ?? []
    }
    
    func getUpToDatePrompt(for basePrompt: Prompt) -> Prompt {
        prompts.first(where: { $0.id == basePrompt.id }) ?? basePrompt
    }
    
    func filteredPromts(showOnlyFavorites: Bool) -> [Prompt] {
        showOnlyFavorites ? prompts.filter(\.isFavorite) : prompts
    }
    
    func addPrompt(title: String, content: String, category: Category) {
        let record = PromptRecord(
            title: title,
            content: content,
            categoryRawValue: category.rawValue,
            isFavorite: false,
            creationDate: Date()
        )

        modelContext.insert(record)
        try? modelContext.save()
        loadPrompts()
    }
    
    func toggleFavorite(_ prompt: Prompt) {
        let predicate = #Predicate<PromptRecord> { $0.id == prompt.id }
        var descriptor = FetchDescriptor<PromptRecord>(predicate: predicate)
        descriptor.fetchLimit = 1

        guard let record = try? modelContext.fetch(descriptor).first else { return }
        record.isFavorite.toggle()
        try? modelContext.save()
        loadPrompts()
    }
    
    func deletePrompt(_ prompt: Prompt) {
        let predicate = #Predicate<PromptRecord> { $0.id == prompt.id }
        var descriptor = FetchDescriptor<PromptRecord>(predicate: predicate)
        descriptor.fetchLimit = 1

        guard let record = try? modelContext.fetch(descriptor).first else { return }
        modelContext.delete(record)
        try? modelContext.save()
        loadPrompts()
    }
    
    func didTapAddPrompt() {
        onAddPrompt?()
    }
    
    func didSelectPrompt(_ prompt: Prompt) {
        onPromptSelected?(prompt)
    }
}
