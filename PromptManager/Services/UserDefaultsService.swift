import Foundation

protocol UserDefaultsServiceProtocol {
    func setBool(_ value: Bool, for flag: UserDefaultsService.Flag)
    func bool(for flag: UserDefaultsService.Flag) -> Bool
    func data(for flag: UserDefaultsService.Flag) -> Data?
    func setData(_ data: Data, for flag: UserDefaultsService.Flag)
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
    
    
    func setData(_ data: Data, for flag: Flag) {
        defaults.set(data, forKey: flag.rawValue)
    }
    
    func data(for flag: Flag) -> Data? {
        defaults.data(forKey: flag.rawValue)
    }
    
    
    enum Flag: String {
        case hasCompletedOnboarding
        case saveKeyPrompts
    }
}
