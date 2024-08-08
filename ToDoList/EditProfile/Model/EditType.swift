//
//  EditType.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 2.08.2024.
//

import Foundation

/// `EditType` enum'u, düzenlenebilecek farklı kullanıcı bilgilerini tanımlar.
///
/// Bu enum, kullanıcı adı, e-posta ve şifre düzenlemeleri için çeşitli yardımcı özellikler sağlar.
enum EditType: CaseIterable {
    /// Kullanıcı adı düzenleme türü.
    case username
    
    /// E-posta düzenleme türü.
    case email
    
    /// Şifre düzenleme türü.
    case password
    
    /// Düzenleme türüne göre uygun başlık metnini döndürür.
    ///
    /// - Returns: Düzenleme türüne bağlı olarak lokalize edilmiş başlık metni.
    var title: String {
        switch self {
        case .username:
            return String(localized: "Edit Username")
        case .email:
            return String(localized: "Update Email")
        case .password:
            return String(localized: "Update Password")
        }
    }
    
    /// Düzenleme türüne göre uygun buton metnini döndürür.
    ///
    /// - Returns: Düzenleme türüne bağlı olarak lokalize edilmiş buton metni.
    var buttonText: String {
        switch self {
        case .username:
            return String(localized: "Update Username")
        case .email:
            return String(localized: "Update Email")
        case .password:
            return String(localized: "Update Password")
        }
    }
    
    /// Düzenleme türüne göre uygun lokalize edilmiş başlık metnini döndürür.
    ///
    /// - Returns: Düzenleme türüne bağlı olarak lokalize edilmiş başlık metni.
    var localizedTitle: String {
        switch self {
        case .username:
            return String(localized: "User Name")
        case .email:
            return String(localized: "Email")
        case .password:
            return String(localized: "Password")
        }
    }
}
