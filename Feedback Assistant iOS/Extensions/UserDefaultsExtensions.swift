//
//  UserDefaultsExtensions.swift
//  Feedback Assistant iOS
//

import Foundation

extension UserDefaults {
    func setCodable<T: Codable>(_ value: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(value) {
            self.set(encoded, forKey: key)
        }
    }
    
    func codable<T: Codable>(forKey key: String) -> T? {
        guard let data = self.data(forKey: key),
              let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return decoded
    }
}
