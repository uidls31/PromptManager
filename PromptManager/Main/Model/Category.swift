import SwiftUI

enum Category: String, Codable, CaseIterable {
    case development = "Development"
    case content = "Content"
    case design = "Design"
    case productivity = "Productivity"
    case other = "Other"
    
    var color: Color {
        switch self {
        case .development: return .blue
        case .content: return .purple
        case .design: return .pink
        case .productivity: return .orange
        case .other: return .mint
        }
    }
}
