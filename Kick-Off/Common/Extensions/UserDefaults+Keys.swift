//
//  UserDefaults+Keys.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 7.03.2022.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }

    var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.accessToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.accessToken)
        }
    }

    var refreshToken: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.refreshToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.refreshToken)
        }
    }
}
