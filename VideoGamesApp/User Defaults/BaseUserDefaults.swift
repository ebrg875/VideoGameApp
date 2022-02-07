//
//  BaseUserDefaults.swift
//  VideoGameApp
//
//  Created by emeksu.barug on 7.02.2022.
//

import Foundation
import RxSwift

public enum UserDefaultsKeys: String {
    case favourites = "Favourites"
}

public class BaseUserDefaults {

    private let defaults: UserDefaults!

    init() {
        self.defaults = UserDefaults()
    }

    public func addNewKey<T: Codable>(key: UserDefaultsKeys, value: T) {
        guard self.defaults.object(forKey: key.rawValue) as? Data == nil,
              let data = try? JSONEncoder().encode(value) else { return }
        self.defaults.set(data, forKey: key.rawValue)
    }

    public func store<T: Codable>(with key: UserDefaultsKeys, value: T) -> Single<Void> {
        return Observable.create { [weak self] observer in
            guard let data = try? JSONEncoder().encode(value) else {
                observer.onError(UserDefaultsError.invalidJson)
                return Disposables.create()
            }
            self?.defaults.set(data, forKey: key.rawValue)
            observer.onNext(())
            observer.onCompleted()

            return Disposables.create()
        }.asSingle()
    }


    public func retrieve<T: Codable>(with key: UserDefaultsKeys) -> Single<T> {
        return Observable.create { [weak self] observer in
            guard
                let data = self?.defaults.object(forKey: key.rawValue) as? Data,
                let model = try? JSONDecoder().decode(T.self, from: data) else {
                    observer.onError(UserDefaultsError.invalidJson)
                    return Disposables.create()
                }
            observer.onNext(model)
            observer.onCompleted()

            return Disposables.create()
        }.asSingle()
    }
}

enum UserDefaultsError: Error {
    case invalidJson
    case keyNotFound
}

extension UserDefaultsError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidJson:
            return NSLocalizedString("Error encountered while parsing JSON data", comment: "Invalid JSON")
        case .keyNotFound:
            return NSLocalizedString("Given key not found in User Defaults", comment: "Key not found")
        }
    }
}
