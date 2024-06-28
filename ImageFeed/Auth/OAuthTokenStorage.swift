//
//  OAuthTokenStorage.swift
//  ImageFeed
//
//  Created by Artem on 27.06.2024.
//

import Foundation

final class OAuthTokenStorage {
    private let userDefaults = UserDefaults.standard
    let tokenKey = "token"
    
    var token: String? {
        get {
            userDefaults.string(forKey: tokenKey)
        }
        set {
            guard let token = newValue else {
                userDefaults.removeObject(forKey: tokenKey)
                return
            }
            userDefaults.setValue(token, forKey: tokenKey)
        }
    }
    
    func clearToken() {
        userDefaults.removeObject(forKey: tokenKey)
    }
}
