import Foundation

struct Prompt: Identifiable, Codable, Equatable, Hashable {
    var id: UUID
    var title: String
    var content: String
    var category: Category
    var isFavorite: Bool
    var creationDate: Date

    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        category: Category,
        isFavorite: Bool = false,
        creationDate: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.category = category
        self.isFavorite = isFavorite
        self.creationDate = creationDate
    }
}
