//
//  RegisterViewViewModel.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation

/// `RegisterViewViewModel` sınıfı, kayıt işlemlerini yöneten ve kullanıcı verilerini işleyen bir ViewModel'dir.
///
/// Bu sınıf, kayıt işlemi sırasında kullanılan ad, e-posta ve şifre verilerini tutar ve doğrulama işlemlerini gerçekleştirir. Ayrıca, kayıt işleminin sonuçlarını işler ve gerekli durum değişikliklerini yönetir.
///
/// ### Özellikler
/// - `name`: Kullanıcının kayıt için girdiği ad.
/// - `email`: Kullanıcının kayıt için girdiği e-posta adresi.
/// - `password`: Kullanıcının kayıt için girdiği şifre.
/// - `isAuthenticated`: Kullanıcının kayıt işlemi sonrası giriş yapıp yapmadığını belirten durum.
/// - `errorMessage`: Kayıt işlemi sırasında oluşan hata mesajlarını tutar.
///
/// ### Fonksiyonlar
/// - `register()`: Kayıt işlemini başlatır ve sunucudan yanıt alır.
/// - `validate() -> Bool`: Kayıt formundaki verilerin doğruluğunu kontrol eder.
class RegisterViewViewModel: BaseViewModel {
    /// Kullanıcının kayıt için girdiği ad.
    @Published var name = ""
    
    /// Kullanıcının kayıt için girdiği e-posta adresi.
    @Published var email = ""
    
    /// Kullanıcının kayıt için girdiği şifre.
    @Published var password = ""
    
    /// Kullanıcının kayıt işlemi sonrası giriş yapıp yapmadığını belirten durum.
    @Published var isAuthenticated: Bool = false
    
    /// Kayıt işlemi sırasında oluşan hata mesajlarını tutar.
    @Published var errorMessage: String = ""
    
    override init() {}
    
    /// Kayıt işlemini başlatır ve sunucudan yanıt alır.
    func register() {
        guard validate() else {
            return
        }
        buttonState = true
        let url = UserRouter.register(name: name, email: email, password: password)
        ApiService.shared.request(url, type: LoginResponse.self) { result, statusCode in
            switch result {
            case .success(let response):
                if response.success == 1, let user = response.user, let token = response.token {
                    UserDefaults.standard.saveUser(user)
                    UserDefaults.standard.set(true, forKey: "isAuthenticated")
                    UserDefaults.standard.set(token, forKey: "jwtToken")
                    self.isAuthenticated = true
                } else {
                    self.errorMessage = response.message
                }
                self.buttonState = false
            case .failure(let error):
                self.isAuthenticated = false
                self.errorMessage = "Kayıt başarısız: \(error.localizedDescription)"
                self.buttonState = false
            }
        }
    }
    /// Kayıt formundaki verilerin doğruluğunu kontrol eder.
    ///
    /// - Returns: Kayıt verileri geçerli ise `true`, değilse `false` döner.
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.errorMessage = String(localized: "Required fields are missing")
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            self.errorMessage = String(localized: "Check your email address.")
            return false
        }
        
        guard password.count >= 6 else {
            self.errorMessage = String(localized: "Your password must be greater than 6 digits.")
            return false
        }
        
        return true
    }
}
