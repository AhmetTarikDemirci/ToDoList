//
//  SettingsViewViewModel.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation
import SwiftUI

/// `SettingsViewViewModel` sınıfı, ayar ekranını yönetmek için kullanılan ViewModel'dir.
///
/// Bu sınıf, profil düzenleme, tema değiştirme, hesap silme ve çıkış yapma gibi işlemleri sağlar.
class SettingsViewViewModel: ObservableObject {
    /// Profil düzenleme ekranının aktif olup olmadığını belirten durum.
    @Published var isEditProfileActive = false
    
    /// Tema değiştirme durumunu belirten değişken.
    @Published var changeTheme = false
    
    @Published var showAlert = false
    
    /// Kullanıcının tema tercihi.
    @AppStorage("userTheme") var userTheme: Theme = .systemDefault
    
    /// Ana ViewModel üzerinden çıkış yapar.
    ///
    /// - Parameter mainViewModel: Uygulamanın ana ViewModel'i.
    func logout(mainViewModel: MainViewViewModel) {
        mainViewModel.logout()
    }
    
    /// Ana ViewModel üzerinden kullanıcı hesabını siler.
    ///
    /// - Parameter mainViewModel: Uygulamanın ana ViewModel'i.
    func deleteAccount(mainViewModel: MainViewViewModel) {
        let request = UserRouter.deleteAccount
        ApiService.shared.request(request, type: ApiResponse.self) { result, statusCode in
            switch result {
            case .success:
                self.logout(mainViewModel: mainViewModel)
            case .failure(let error):
                print("Failed to delete account: \(error.localizedDescription)")
            }
        }
    }
    
    /// Temayı değiştirir.
    func toggleTheme() {
        changeTheme.toggle()
    }
    
    /// Profil düzenleme ekranını aktif hale getirir.
    func editProfile() {
        isEditProfileActive = true
    }
}
