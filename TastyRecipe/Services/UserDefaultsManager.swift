//
//  UserDefaultsManager.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 12.09.2024.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    private init() { }
    
    // MARK: - Save Data
    func save<T>(value: T, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    // MARK: - Get Data
    func get<T>(forKey key: String) -> T? {
        return defaults.value(forKey: key) as? T
    }
    
    // MARK: - Remove Data
    func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
    // MARK: - Save Codable Data
    func saveCodable<T: Codable>(value: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            defaults.set(encoded, forKey: key)
        }
    }
    
    // MARK: - Get Codable Data
    func getCodable<T: Codable>(forKey key: String, type: T.Type) -> T? {
        if let savedData = defaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(type, from: savedData) {
                return loadedData
            }
        }
        return nil
    }
    
    // MARK: - Check If Key Exists
    func keyExists(_ key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
}
