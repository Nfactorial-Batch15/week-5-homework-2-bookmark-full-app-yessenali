//
//  AppStorage.swift
//  BookmarkUIKit
//
//  Created by Yessenali Zhanaidar on 23.01.2022.
//

import Foundation

class Storage {
    @AppDataStorage(key: "link_models", defaultValue: [])
    static var linkModels: [LinkData]

}

@propertyWrapper
struct AppDataStorage<T: Codable> {
    private let key: String
    private let defaultValue: T // Generic

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T { // generic
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else { //name surname age or price name
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data) // попытайся приготовить суп
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue) //  попытайся вытащить ингредиенты из супа
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
