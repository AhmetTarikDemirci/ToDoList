//
//  UserDefaultsExtensions.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation

/// `UserDefaults` uzantısı, kullanıcı bilgilerini saklamak ve almak için çeşitli yardımcı yöntemler sağlar.
///
/// Bu uzantı, `User` modelinin UserDefaults'da saklanması ve alınması işlemlerini basitleştirir.
extension UserDefaults {
    
    /// UserDefaults anahtarları için kullanılan sabitler.
    private enum Keys {
        static let userId = "userId"
        static let userName = "userName"
        static let email = "email"
        static let dateOfRegistration = "dateOfRegistration"
    }

    /// Verilen kullanıcıyı UserDefaults'a kaydeder.
    ///
    /// - Parameter user: Kaydedilecek `User` nesnesi.
    func saveUser(_ user: User) {
        saveUserId(user.id)
        saveUserName(user.userName)
        saveEmail(user.email)
        saveDateOfRegistration(user.dateOfRegistration)
    }

    /// Verilen kullanıcı ID'sini UserDefaults'a kaydeder.
    ///
    /// - Parameter id: Kaydedilecek kullanıcı ID'si.
    func saveUserId(_ id: Int) {
        set(id, forKey: Keys.userId)
    }

    /// UserDefaults'dan kullanıcı ID'sini alır.
    ///
    /// - Returns: Kaydedilmiş kullanıcı ID'si veya `nil`.
    func getUserId() -> Int? {
        return integer(forKey: Keys.userId)
    }

    /// Verilen kullanıcı adını UserDefaults'a kaydeder.
    ///
    /// - Parameter userName: Kaydedilecek kullanıcı adı.
    func saveUserName(_ userName: String) {
        set(userName, forKey: Keys.userName)
    }

    /// UserDefaults'dan kullanıcı adını alır.
    ///
    /// - Returns: Kaydedilmiş kullanıcı adı veya `nil`.
    func getUserName() -> String? {
        return string(forKey: Keys.userName)
    }

    /// Verilen e-posta adresini UserDefaults'a kaydeder.
    ///
    /// - Parameter email: Kaydedilecek e-posta adresi.
    func saveEmail(_ email: String) {
        set(email, forKey: Keys.email)
    }

    /// UserDefaults'dan e-posta adresini alır.
    ///
    /// - Returns: Kaydedilmiş e-posta adresi veya `nil`.
    func getEmail() -> String? {
        return string(forKey: Keys.email)
    }

    /// Verilen kayıt tarihini UserDefaults'a kaydeder.
    ///
    /// - Parameter date: Kaydedilecek kayıt tarihi (TimeInterval olarak).
    func saveDateOfRegistration(_ date: TimeInterval) {
        set(date, forKey: Keys.dateOfRegistration)
    }

    /// UserDefaults'dan kayıt tarihini alır.
    ///
    /// - Returns: Kaydedilmiş kayıt tarihi veya `nil`.
    func getDateOfRegistration() -> TimeInterval? {
        return double(forKey: Keys.dateOfRegistration)
    }

    /// UserDefaults'dan kullanıcı bilgilerini siler.
    func deleteUser() {
        removeObject(forKey: Keys.userId)
        removeObject(forKey: Keys.userName)
        removeObject(forKey: Keys.email)
        removeObject(forKey: Keys.dateOfRegistration)
    }

    /// UserDefaults'dan kullanıcı bilgilerini alır.
    ///
    /// - Returns: Kaydedilmiş `User` nesnesi veya `nil`.
    func getUser() -> User? {
        guard let userId = getUserId(),
              let userName = getUserName(),
              let email = getEmail(),
              let dateOfRegistration = getDateOfRegistration() else {
            return nil
        }
        return User(id: userId, userName: userName, email: email, dateOfRegistration: dateOfRegistration)
    }
}
