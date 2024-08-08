import Foundation
import SwiftUI

/// `UserViewModel` sınıfı, kullanıcı bilgilerini yönetmek ve güncellemeleri işlemek için kullanılan bir ViewModel'dir.
///
/// Bu sınıf, kullanıcı adı, e-posta ve şifre gibi bilgilerin doğrulanmasını ve güncellenmesini sağlar.
class UserViewModel: ObservableObject {
    /// Kullanıcının adı.
    @Published var userName: String = ""
    
    /// Kullanıcının e-posta adresi.
    @Published var email: String = ""
    
    /// Kullanıcının yeni şifresi.
    @Published var newPassword: String = ""
    
    /// Kullanıcının mevcut şifresi.
    @Published var currentPassword: String = ""
    
    /// Kullanıcıya gösterilecek mesaj.
    @Published var message: String = ""
    
    /// Mesajın gösterilip gösterilmeyeceğini belirten durum.
    @Published var showMessage: Bool = false
    
    /// Mesajın rengi.
    @Published var messageColor: Color = .red

    /// Kullanıcı girdi doğrulamasını yapar.
    ///
    /// - Parameters:
    ///   - field: Doğrulanacak alanın değeri.
    ///   - fieldName: Alanın adı.
    ///   - minLength: Alanın minimum uzunluğu (varsayılan: 0).
    /// - Returns: Doğrulama başarılıysa `true`, aksi takdirde `false`.
    func validateInput(field: String, fieldName: String, minLength: Int = 0) -> Bool {
        guard !field.trimmingCharacters(in: .whitespaces).isEmpty else {
            setMessage(String(localized: "Please enter \(fieldName)"), color: .red)
            return false
        }
        if minLength > 0, field.count < minLength {
            setMessage(String(localized: "\(fieldName.capitalized) must be at least \(minLength) characters"), color: .red)
            return false
        }
        return true
    }

    /// E-posta adresi doğrulamasını yapar.
    ///
    /// - Returns: Doğrulama başarılıysa `true`, aksi takdirde `false`.
    func validateEmail() -> Bool {
        guard email.contains("@") && email.contains(".") else {
            setMessage(String(localized: "Please enter a valid email address"), color: .red)
            return false
        }
        return true
    }

    /// Kullanıcı adı güncellemesi için doğrulamaları yapar.
    ///
    /// - Returns: Doğrulama başarılıysa `true`, aksi takdirde `false`.
    func validateUsernameUpdate() -> Bool {
        return validateInput(field: userName, fieldName: "username") &&
               validateInput(field: currentPassword, fieldName: "current password")
    }

    /// E-posta güncellemesi için doğrulamaları yapar.
    ///
    /// - Returns: Doğrulama başarılıysa `true`, aksi takdirde `false`.
    func validateEmailUpdate() -> Bool {
        return validateInput(field: email, fieldName: "email") &&
               validateEmail() &&
               validateInput(field: currentPassword, fieldName: "current password")
    }

    /// Şifre güncellemesi için doğrulamaları yapar.
    ///
    /// - Returns: Doğrulama başarılıysa `true`, aksi takdirde `false`.
    func validatePasswordUpdate() -> Bool {
        return validateInput(field: newPassword, fieldName: "new password", minLength: 6) &&
               validateInput(field: currentPassword, fieldName: "current password")
    }

    /// Kullanıcıya gösterilecek mesajı ayarlar.
    ///
    /// - Parameters:
    ///   - message: Gösterilecek mesaj.
    ///   - color: Mesajın rengi.
    private func setMessage(_ message: String, color: Color) {
        self.message = message
        self.showMessage = true
        self.messageColor = color
    }

    /// API yanıtlarını işler.
    ///
    /// - Parameters:
    ///   - result: API yanıt sonucu.
    ///   - successMessage: Başarılı işlem mesajı.
    private func handleApiResponse(result: Result<ApiResponse, Error>, successMessage: String) {
        DispatchQueue.main.async {
            switch result {
            case .success(let response):
                self.setMessage(response.message ?? successMessage, color: .green)
                self.currentPassword = ""
                self.newPassword = ""
            case .failure(let error):
                self.setMessage(error.localizedDescription, color: .red)
            }
        }
    }

    /// Kullanıcı adını günceller.
    func updateUserName() {
        guard validateUsernameUpdate() else { return }
        let request = UserRouter.updateUsername(userName: userName, password: currentPassword)
        ApiService.shared.request(request, type: ApiResponse.self) { result, _ in
            self.handleApiResponse(result: result, successMessage: "Username updated successfully")
        }
    }

    /// E-posta adresini günceller.
    func updateEmail() {
        guard validateEmailUpdate() else { return }
        let request = UserRouter.updateEmail(email: email, password: currentPassword)
        ApiService.shared.request(request, type: ApiResponse.self) { result, _ in
            self.handleApiResponse(result: result, successMessage: "Email updated successfully")
        }
    }

    /// Şifreyi günceller.
    func updatePassword() {
        guard validatePasswordUpdate() else { return }
        let request = UserRouter.updatePassword(newPassword: newPassword, currentPassword: currentPassword)
        ApiService.shared.request(request, type: ApiResponse.self) { result, _ in
            self.handleApiResponse(result: result, successMessage: "Password updated successfully")
        }
    }
}
