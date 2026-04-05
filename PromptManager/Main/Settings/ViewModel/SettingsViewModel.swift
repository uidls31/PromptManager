import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    
    
    let termsOfServiceURL: URL? = URL(string: "https://apple.com")
    let privacyPolicyURL: URL? = URL(string: "https://apple.com")
    
}
