//
//  ApiError.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation

/// `ApiError` enumu, API istekleri sırasında meydana gelebilecek hataları temsil eder.
///
/// Bu enum, çeşitli API hata durumlarını tanımlar ve her hata durumu için bir açıklama sağlar.
///
enum ApiError: Swift.Error, CustomStringConvertible {
    /// - `invalidData`: Geçersiz veri.
    case invalidData
    /// - `errorCastingFailure(data: Data)`: Hata dönüştürme hatası, veri içerir.
    case errorCastingFailure(data: Data)
    /// - `unauthorized(response: ApiErrorResponse)`: Yetkisiz, yanıt içerir.
    case unauthorized(response: ApiErrorResponse)
    /// - `badRequest(String)`: Kötü istek, mesaj içerir.
    case badRequest(String)
    /// - `tokenMissing`: Token eksik.
    case tokenMissing
    /// - `authorizationHeaderMissing`: Yetkilendirme başlığı eksik.
    case authorizationHeaderMissing
    /// - `internalServerError`: Dahili sunucu hatası.
    case internalServerError
    /// - `requestFailed`: İstek başarısız oldu.
    case requestFailed

    /// Hata durumunun açıklamasını içeren bir string.
    var description: String {
        switch self {
        case .invalidData: return "Invalid Data"
        case .errorCastingFailure: return "Cast Failure, create an error object"
        case .unauthorized: return "Unauthorized"
        case .badRequest(let message): return "\(message)"
        case .tokenMissing: return "Token Missing"
        case .authorizationHeaderMissing: return "Authorization Header Missing"
        case .internalServerError: return "Internal Server Error"
        case .requestFailed: return "Request Failed"
            
        }
    }
}
