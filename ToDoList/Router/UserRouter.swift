//
//  UserRouter.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation
import Alamofire

/// `UserRouter` enumu, kullanıcı işlemlerini yöneten API isteklerini yapılandırır.
///
/// Bu enum, kullanıcıların sisteme giriş yapma, kayıt olma, kullanıcı adı güncelleme,
/// email güncelleme, şifre güncelleme ve hesap silme gibi işlemlerini yöneten API isteklerini yapılandırmak için kullanılır.
///
/// Her bir case, belirli bir kullanıcı işlemini temsil eder ve bu işlemler için gerekli olan URL, HTTP yöntemi, parametreler ve başlıkları yapılandırır.
///
/// Tüm API istekleri, `https://ahmettarikdemirci.io/todolist` temel URL'sine yapılır.
///
/// Örneğin, `UserRouter.login(email: "example@example.com", password: "password")` isteği,
/// `/login` yoluna bir POST isteği gönderir ve gövdeye `{ "email": "example@example.com", "password": "password" }`
/// JSON parametrelerini ekler.
///
/// **Not:** `UserRouter` sadece istek yapılandırmasını yapar, isteği göndermez.
/// API isteklerini göndermek için bu yapılandırmaları kullanarak bir `URLRequest` oluşturulmalı ve `Alamofire` gibi bir kütüphane kullanılarak istek gönderilmelidir.
///
enum UserRouter {
    case login(email: String, password: String)
    case register(name: String, email: String, password: String)
    case updateUsername(userName: String, password: String)
    case updateEmail(email: String, password: String)
    case updatePassword(newPassword: String, currentPassword: String)
    case deleteAccount
}

extension UserRouter: URLRequestConfigurable {
    
    /// API'nin temel URL'si.
    var baseURL: URL? {
        return URL(string: ApiConstants.baseURLString)
    }
    
    /// İstek için kullanılacak URL yolu.
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .register:
            return "/register"
        case .updateUsername:
            return "/update_username"
        case .updateEmail:
            return "/update_email"
        case .updatePassword:
            return "/update_password"
        case .deleteAccount:
            return "/delete_account"
        }
    }
    
    /// HTTP yöntemi.
    var method: HTTPMethod {
        switch self {
        case .login, .register, .updateUsername, .updateEmail, .updatePassword:
            return .post
        case .deleteAccount:
            return .delete
        }
    }
    
    /// İstek gövdesine eklenmesi gereken parametreler.
    var bodyParameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return ["email": email, "password": password]
        case .register(let name, let email, let password):
            return ["user_name": name, "email": email, "password": password]
        case .updateUsername(let userName, let password):
            return ["user_name": userName, "password": password]
        case .updateEmail(let email, let password):
            return ["email": email, "password": password]
        case .updatePassword(let newPassword, let currentPassword):
            return ["new_password": newPassword, "current_password": currentPassword]
        case .deleteAccount:
            return nil
        }
    }
    
    /// URL'ye eklenmesi gereken parametreler.
    var urlParameters: Parameters? {
        return nil
    }
    
    /// İstek için gerekli olan başlıklar.
    var headers: HTTPHeaders? {
        var headers: [HTTPHeader] = []
        switch self {
        case .login, .register:
            break
        default:
            if let jwtToken = UserDefaults.standard.string(forKey: "jwtToken") {
                headers.append(.authorization(bearerToken: jwtToken))
            }
        }
        headers.append(.contentType("application/json"))
        return HTTPHeaders(headers)
    }
    
    /// Gövde parametrelerinin nasıl kodlanacağını belirtir.
    var bodyParameterEncoding: BodyParameterEncoding {
        return .jsonEncoding
    }
    
    /// URLRequest oluşturur ve yapılandırır.
    func asURLRequest() throws -> URLRequest {
        guard let url = baseURL?.appendingPathComponent(path) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers ?? []
        
        if let parameters = bodyParameters {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
