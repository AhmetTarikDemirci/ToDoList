//
//  LoginViewViewModel.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation
/// `LoginViewViewModel` sınıfı, giriş işlemlerini yöneten ve kullanıcı verilerini işleyen bir ViewModel'dir.
///
/// Bu sınıf, giriş işlemi sırasında kullanılan e-posta ve şifre verilerini tutar ve doğrulama işlemlerini gerçekleştirir. Ayrıca, giriş işleminin sonuçlarını işler ve gerekli durum değişikliklerini yönetir.
///
class LoginViewViewModel: BaseViewModel {
    /// Kullanıcının giriş için girdiği e-posta adresi.
    @Published var email = ""
    
    /// Kullanıcının giriş için girdiği şifre.
    @Published var password = ""
    
    /// Giriş işlemi sırasında oluşan hata mesajlarını tutar.
    @Published var errorMessage = ""
    
    /// Kullanıcının giriş yapıp yapmadığını belirten durum.
    @Published var isAuthenticated: Bool = false
    
    /// Giriş işlemi başarılı olduğunda kullanıcının bilgilerini tutar.
    @Published var user: User?
    
    override init() {}
    
    /// Giriş işlemini başlatır ve sunucudan yanıt alır.
    func login() {
        guard validate() else {
            return
        }
        buttonState = true
        let request = UserRouter.login(email: email, password: password)
        ApiService.shared.request(request, type: LoginResponse.self) { [weak self] result, statusCode in
            DispatchQueue.main.async {
                self?.handleResponse(result: result)
            }
        }
    }
    
    /// Sunucudan gelen yanıtı işler ve gerekli durum değişikliklerini yapar.
    ///
    /// - Parameter result: Sunucudan gelen yanıt.
    private func handleResponse(result: Result<LoginResponse, Error>) {
        buttonState = false
        switch result {
            
        case .success(let response):
            if response.success == 1, let user = response.user, let token = response.token {
                UserDefaults.standard.saveUser(user)
                UserDefaults.standard.set(true, forKey: "isAuthenticated")
                UserDefaults.standard.set(token, forKey: "jwtToken")
                self.user = user
                self.isAuthenticated = true
              
            } else {
                self.errorMessage = response.message
            }
        case .failure(let error):
            self.errorMessage = self.getErrorMessage(error: error)
            print(error)
        }
    }
    
    /// Giriş formundaki verilerin doğruluğunu kontrol eder.
    ///
    /// - Returns: Giriş verileri geçerli ise `true`, değilse `false` döner.
    func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = String(localized: "Please fill in all fields")
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = String(localized: "Please enter a valid email")
            return false
        }
        return true
    }
    
    /// Hata mesajını döndürür.
    ///
    /// - Parameter error: Oluşan hata.
    /// - Returns: Hata mesajı.
    private func getErrorMessage(error: Error) -> String {
        if let apiError = error as? ApiError {
            return apiError.description
        } else {
            return error.localizedDescription
        }
    }
}
