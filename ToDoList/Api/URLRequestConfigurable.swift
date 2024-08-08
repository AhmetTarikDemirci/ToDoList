//
//  URLRequestConfigurable.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 26.07.2024.
//

import Foundation
import Alamofire

/// `URLRequestConfigurable` protokolü, URL isteklerini yapılandırmak için gerekli olan özellikleri ve fonksiyonları tanımlar.
///
/// Bu protokol, URL isteklerini yapılandırmak için temel bilgileri sağlar ve URLRequestConvertible protokolünü uygular.
protocol URLRequestConfigurable: URLRequestConvertible {
    /// Temel URL adresini temsil eder.
    var baseURL: URL? { get }
    
    /// URL yolunu belirtir.
    var path: String { get }
    
    /// HTTP isteğinin yöntemini belirtir.
    var method: HTTPMethod { get }
    
    /// URL'ye eklenecek parametreler.
    var urlParameters: Parameters? { get }
    
    /// HTTP isteğinin gövdesine eklenecek parametreler.
    var bodyParameters: Parameters? { get }
    
    /// Gövde parametrelerinin nasıl kodlanacağını belirler.
    var bodyParameterEncoding: BodyParameterEncoding { get }
    
    /// HTTP başlıklarını içerir.
    var headers: HTTPHeaders? { get }
}

extension URLRequestConfigurable {
    
    /// Yetkilendirme HTTP başlığını döner.
    ///
    /// Eğer bir JWT token mevcutsa, "Authorization" başlığı ile birlikte döner. Aksi takdirde, nil döner.
    var authorizationHTTPHeader: HTTPHeader? {
        if let token = UserDefaults.standard.string(forKey: "jwtToken") {
            return HTTPHeader(name: "Authorization", value: "Bearer \(token)")
        }
        return nil
    }
    
    /// URL isteğini yapılandırır.
    ///
    /// - Parameter urlRequest: Yapılandırılacak URL isteği.
    /// - Throws: URL yapılandırma hataları.
    func configure(urlRequest: inout URLRequest) throws {
        urlRequest.httpMethod = self.method.rawValue
        
        var headers = self.headers ?? HTTPHeaders()
        headers.add(name: "Accept", value: "application/json")
        
        if let authorizationHeader = authorizationHTTPHeader {
            headers.add(authorizationHeader)
        }
        
        urlRequest.headers = headers

        urlRequest = try URLEncoding(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal).encode(urlRequest, with: urlParameters)

        switch bodyParameterEncoding {
        case .jsonEncoding:
            urlRequest = try JSONEncoding(options: .prettyPrinted).encode(urlRequest, with: bodyParameters)
        case .formUrlEncoding:
            urlRequest = try URLEncoding(destination: .httpBody, arrayEncoding: .noBrackets, boolEncoding: .literal).encode(urlRequest, with: bodyParameters)
        }
    }
}
