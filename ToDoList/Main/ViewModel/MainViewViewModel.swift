//
//  MainViewViewModel.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation

/// `MainViewViewModel` sınıfı, ana görünümde kullanıcı kimlik doğrulamasını ve kullanıcı verilerini yöneten bir ViewModel'dir.
///
/// Bu sınıf, kullanıcı kimlik doğrulama durumunu kontrol eder, kullanıcı bilgilerini yükler ve günceller. Ayrıca, kullanıcı çıkış işlemlerini de yönetir.
///
class MainViewViewModel: ObservableObject {
    /// Kullanıcının kimlik doğrulama durumunu belirten durum.
    @Published var isAuthenticated: Bool = false
    
    /// Kullanıcı bilgilerini tutan `User` modeli.
    @Published var user: User? = nil
    
    static let shared = MainViewViewModel() // Singleton instance for easy access
    
    /// `MainViewViewModel` sınıfının başlatıcısı.
    init() {
        checkAuthentication()
        loadUser()
    }
    
    /// Kullanıcının kimlik doğrulama durumunu kontrol eder.
    func checkAuthentication() {
        self.isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
    }
    
    /// Kullanıcıyı çıkış yaptırır ve kimlik doğrulama durumunu sıfırlar.
    func logout() {
        self.isAuthenticated = false
        UserDefaults.standard.set(false, forKey: "isAuthenticated")
        UserDefaults.standard.deleteUser()
        UserDefaults.standard.removeObject(forKey: "jwtToken")
    }
    
    /// Kullanıcı bilgilerini yükler.
    func loadUser() {
        self.user = UserDefaults.standard.getUser()
    }
    
    /// Kullanıcının adını günceller ve kaydeder.
    ///
    /// - Parameter userName: Güncellenmiş kullanıcı adı.
    func saveUserName(_ userName: String) {
        UserDefaults.standard.saveUserName(userName)
        self.user = UserDefaults.standard.getUser()
    }
    
    /// Kullanıcının e-posta adresini günceller ve kaydeder.
    ///
    /// - Parameter email: Güncellenmiş e-posta adresi.
    func saveEmail(_ email: String) {
        UserDefaults.standard.saveEmail(email)
        self.user = UserDefaults.standard.getUser()
    }
    
    /// Kullanıcı bilgilerini kaydeder ve günceller.
    ///
    /// - Parameter user: Kaydedilecek kullanıcı bilgileri.
    func saveUser(_ user: User) {
        UserDefaults.standard.saveUser(user)
        self.user = user
    }
}
