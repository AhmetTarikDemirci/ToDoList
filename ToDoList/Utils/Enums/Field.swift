//
//  Field.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 2.08.2024.
//

import Foundation

/// `Field` enum'u, kullanıcı bilgilerini temsil eden alanları tanımlar.
///
/// Bu enum, kullanıcı adı, e-posta, şifre ve yeni şifre gibi alanları içerir.
///
/// Örnek Kullanım:
/// ```swift
/// let field: Field = .username
/// switch field {
/// case .username:
///     print("Kullanıcı adı alanı")
/// case .email:
///     print("E-posta alanı")
/// case .password:
///     print("Şifre alanı")
/// case .newPassword:
///     print("Yeni şifre alanı")
/// }
/// ```
enum Field: Hashable {
    /// Kullanıcı adı alanı.
    case username
    
    /// E-posta alanı.
    case email
    
    /// Şifre alanı.
    case password
    
    /// Yeni şifre alanı.
    case newPassword
}
