import SwiftUI

extension ShapeStyle where Self == LinearGradient {
    static var appBackground: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.33, green: 0.29, blue: 0.98),
                Color(red: 0.10, green: 0.55, blue: 0.98),
                Color(red: 0.36, green: 0.83, blue: 0.88),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
