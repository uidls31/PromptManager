import Foundation
import SwiftData

@Model
final class PromptRecord {
    @Attribute(.unique) var id: UUID
    var title: String
    var content: String
    var categoryRawValue: String
    var isFavorite: Bool
    var creationDate: Date

    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        categoryRawValue: String,
        isFavorite: Bool = false,
        creationDate: Date = .now
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.categoryRawValue = categoryRawValue
        self.isFavorite = isFavorite
        self.creationDate = creationDate
    }
}

extension PromptRecord {
    var prompt: Prompt {
        Prompt(
            id: id,
            title: title,
            content: content,
            category: Category(rawValue: categoryRawValue) ?? .other,
            isFavorite: isFavorite,
            creationDate: creationDate
        )
    }
}
