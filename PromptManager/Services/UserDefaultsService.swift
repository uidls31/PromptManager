import Foundation

protocol UserDefaultsServiceProtocol {
    func setBool(_ value: Bool, for flag: UserDefaultsService.Flag)
    func bool(for flag: UserDefaultsService.Flag) -> Bool
}

class UserDefaultsService: UserDefaultsServiceProtocol {
    
    static let shared = UserDefaultsService()
    private let defaults = UserDefaults.standard
    
    func setBool(_ value: Bool, for flag: Flag) {
        defaults.set(value, forKey: flag.rawValue)
    }
    
    func bool(for flag: Flag) -> Bool {
        defaults.bool(forKey: flag.rawValue)
    }
    
    
    
    
    enum Flag: String {
        case hasCompletedOnboarding
    }
}
