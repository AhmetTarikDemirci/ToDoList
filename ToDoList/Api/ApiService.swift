//
//  ApiService.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation
import Alamofire
import Combine

typealias JSON = [String: Any]

/// `ApiService` sınıfı, API isteklerini yönetmek için kullanılan bir singleton servisidir.
///
/// Bu sınıf, Alamofire kütüphanesini kullanarak API isteklerini gerçekleştirir ve yanıtları işleyerek ilgili sonuçları döner.
/// Singleton yapısı sayesinde tek bir örnek üzerinden tüm istekler yönetilebilir.
///
/// ### Kullanım Örneği
/// ```
/// ApiService.shared.request(urlRequest, type: MyModel.self) { result, statusCode in
///     switch result {
///     case .success(let model):
///         print("Başarılı: \(model)")
///     case .failure(let error):
///         print("Hata: \(error)")
///     }
/// }
/// ```
final class ApiService {
    
    /// `ApiService` sınıfının tek örneği.
    static let shared = ApiService()
    
    /// Alamofire oturumu.
    private var AFSession: Session
    
    /// Mevcut veri isteği.
    private var dataRequest: DataRequest?
    
    /// Sınıfın başlatıcısı, oturum konfigürasyonunu ayarlar.
    private init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.waitsForConnectivity = true
        self.AFSession = Session(configuration: configuration)
    }
    
    /// Belirtilen URL isteğini gerçekleştirir ve sonucu döner.
    ///
    /// - Parameters:
    ///   - urlReq: URL isteği.
    ///   - type: Beklenen yanıt türü.
    ///   - completion: İstek tamamlandığında çağrılacak tamamlanma bloğu.
    ///                 Tamamlanma bloğu bir `Result` türü ve isteğin durum kodunu döner.
    func request<T: Decodable>(
        _ urlReq: URLRequestConvertible,
        type: T.Type,
        completion: @escaping (Result<T, Error>, Int?) -> Void) {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        
        let dataRequest = AFSession.request(urlReq)
        dataRequest.responseDecodable(of: T.self, decoder: decoder) { response in
            dataRequest.debugLog()
            response.debugLog()
            switch response.result {
            case .success(let value):
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 200...299:
                        completion(.success(value), statusCode)
                    case 400, 401:
                        if let apiError = response.checkError() {
                            if case .unauthorized = apiError {
                                MainViewViewModel.shared.logout()
                            }
                            completion(.failure(apiError), statusCode)
                        } else if let err = response.error {
                            completion(.failure(err), statusCode)
                        }
                    default:
                        completion(.failure(ApiError.requestFailed), statusCode)
                    }
                } else {
                    completion(.failure(ApiError.requestFailed), nil)
                }
            case .failure(let error):
                completion(.failure(error.asApiError), response.response?.statusCode)
            }
        }
    }
}

/// `DataResponse` uzantısı, API yanıtlarını işlemek için çeşitli yardımcı fonksiyonlar sağlar.
extension DataResponse {
    /// API hatasını kontrol eder ve döner.
    ///
    /// Bu fonksiyon, API yanıtındaki hata kodlarını kontrol eder ve uygun hata mesajını döner.
    ///
    /// - Returns: API hatası. Hata yoksa `nil` döner.
    func checkError() -> ApiError? {
        guard let code = self.response?.statusCode else { return nil }
        
        switch code {
        case 200...299:
            return nil
        case 400:
            guard let data = self.data else { return .invalidData }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let message = json["message"] as? String {
                        if message == "Token eksik" || message == "Yetkisiz erişim" {
                            return .unauthorized(response: ApiErrorResponse(error: "Unauthorized", errorDesc: message, errorCode: 401))
                        }
                        return .badRequest(message)
                    } else {
                        return .badRequest("Bad Request")
                    }
                } else {
                    let errObj = try JSONDecoder().decode(ApiErrorResponse.self, from: data)
                    if errObj.errorDesc == nil {
                        return .errorCastingFailure(data: data)
                    } else {
                        if errObj.errorDesc == "Token eksik" || errObj.errorDesc == "Yetkisiz erişim" {
                            return .unauthorized(response: ApiErrorResponse(error: "Unauthorized", errorDesc: errObj.errorDesc!, errorCode: 401))
                        }
                        return .badRequest(errObj.errorDesc ?? "Bad Request")
                    }
                }
            } catch {
                return .errorCastingFailure(data: data)
            }
        case 401:
            return .unauthorized(response: ApiErrorResponse(error: "Unauthorized", errorDesc: "Yetkisiz erişim", errorCode: 401))
        case 500:
            return .internalServerError
        default:
            guard let data = self.data else { return .invalidData }
            return .errorCastingFailure(data: data)
        }
    }
}
