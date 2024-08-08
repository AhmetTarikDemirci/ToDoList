//
//  User.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation

/// `User` yapısı, kullanıcı bilgilerini temsil eder ve `Codable` protokolünü uygular.
///
/// Bu yapı, kullanıcıların kimlik bilgilerini ve kayıt tarihlerini tutar.
struct User: Codable {
    /// Kullanıcı kimliği.
    let id: Int
    
    /// Kullanıcının kullanıcı adı.
    var userName: String
    
    /// Kullanıcının e-posta adresi.
    var email: String
    
    /// Kullanıcının kayıt tarihini temsil eden zaman damgası.
    let dateOfRegistration: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        /// JSON anahtarları ile Swift özellikleri arasındaki eşleşmeleri belirtir.
        case id
        case email
        case userName = "user_name"
        case dateOfRegistration = "date_of_registration"
    }
}
