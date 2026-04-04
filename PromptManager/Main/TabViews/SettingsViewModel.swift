import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    
    let termsOfServiceURL: URL
    let privacyPolicyURL: URL
    
    init(termsOfServiceURL: URL, privacyPolicyURL: URL) {
        self.termsOfServiceURL = termsOfServiceURL
        self.privacyPolicyURL = privacyPolicyURL
    }
    
    func didTapRateUs() {
        
    }
    
}
