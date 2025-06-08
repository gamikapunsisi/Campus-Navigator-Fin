//
//  UserDefaults.swift
//  CampusNavigatorApp
//
//

import Foundation

extension UserDefaults {
    
    private enum Keys {
        static let username = "username"
        static let email = "email"
        static let firstHomePageVisit = "firstHomePageVisit"
    }

    // Store user data
    func saveUser(username: String, email: String) {
        set(username, forKey: Keys.username)
        set(email, forKey: Keys.email)
        set(true, forKey: Keys.firstHomePageVisit) // Set first visit flag
    }

    // Retrieve stored user data
    func getUsername() -> String {
        return string(forKey: Keys.username) ?? "Guest"
    }

    func getEmail() -> String {
        return string(forKey: Keys.email) ?? ""
    }

    func isFirstHomePageVisit() -> Bool {
        return bool(forKey: Keys.firstHomePageVisit)
    }

    func completeTour() {
        set(false, forKey: Keys.firstHomePageVisit)
    }
}
