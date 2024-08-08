//
//  ApiResponse.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation

/// `ApiResponse` yapısı, API'den dönen genel başarılı yanıtları temsil eder.
///
/// Bu yapı, API yanıtlarındaki mesajları tutar ve `Decodable` protokolünü uygular.
///
/// ### Özellikler
/// - `message`: API'den dönen mesaj.
struct ApiResponse: Error, Decodable {
    var message: String?
    
    private enum CodingKeys: String, CodingKey {
        case message
    }
    
    /// `ApiResponse` yapısını bir decoder'dan başlatır.
    ///
    /// - Parameter decoder: Çözümleyici.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decodeIfPresent(String.self, forKey: .message)
    }
}

/// `ApiErrorResponse` yapısı, API'den dönen hata yanıtlarını temsil eder.
///
/// Bu yapı, API hata yanıtlarındaki hata mesajlarını, açıklamalarını ve hata kodlarını tutar ve `Decodable` protokolünü uygular.
///
/// ### Özellikler
/// - `error`: API'den dönen hata mesajı.
/// - `errorDesc`: API'den dönen hata açıklaması.
/// - `errorCode`: API'den dönen hata kodu.
struct ApiErrorResponse: Error {
    var error: String?
    var errorDesc: String?
    var errorCode: Int?
}

extension ApiErrorResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case error
        case errorDesc = "error_description"
        case errorCode = "error_code"
    }
    
    /// `ApiErrorResponse` yapısını bir decoder'dan başlatır.
    ///
    /// - Parameter decoder: Çözümleyici.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        error = try container.decodeIfPresent(String.self, forKey: .error)
        errorDesc = try container.decodeIfPresent(String.self, forKey: .errorDesc)
        
        if let code = try container.decodeIfPresent(Int.self, forKey: .errorCode) {
            errorCode = code
        } else {
            if let codeDesc = try container.decodeIfPresent(String.self, forKey: .errorCode) {
                errorCode = Int(codeDesc)
            }
        }
    }
}
