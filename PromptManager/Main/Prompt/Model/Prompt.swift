import Foundation

struct Prompt: Identifiable, Codable, Equatable, Hashable {
    var id: UUID
    var title: String
    var content: String
    var category: Category
    var isFavorite: Bool
    var creationDate: Date
}
