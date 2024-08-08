//
//  ToDoRouter.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 25.07.2024.
//

import Foundation
import Alamofire

/// `TodoRouter` enumu, yapılacaklar listesi işlemlerini yöneten API isteklerini yapılandırır.
///
/// Bu enum, yapılacaklar listesindeki çeşitli işlemleri yönetmek için gerekli olan URL, HTTP yöntemi, parametreler ve başlıkları yapılandırır.
/// Her bir case, belirli bir yapılacaklar listesi işlemini temsil eder ve bu işlemler için gerekli olan yapılandırmayı sağlar.
///
/// Tüm API istekleri, `https://ahmettarikdemirci.io/todolist` temel URL'sine yapılır.
///
/// Örneğin, `TodoRouter.getTodos` isteği, `https://ahmettarikdemirci.io/todolist/get_todos_not_done` yoluna bir GET isteği gönderir ve yapılmamış görevlerin listesini getirir.
///
/// **Not:** `TodoRouter` yalnızca istek yapılandırmasını yapar, istek göndermez.
/// API isteklerini göndermek için bu yapılandırmaları kullanarak bir `URLRequest` oluşturulmalı ve `Alamofire` gibi bir kütüphane kullanılarak istek gönderilmelidir.
///
enum TodoRouter {
    case getTodos
    case getTodosDone
    case addTodo(todoItem: ToDoListItem)
    case editTodo(todoItem: ToDoListItem)
    case deleteTodo(id: String)
    case addCategory(categoryName: String)
    case updateCategory(id: Int, categoryName: String)
    case updateIsDone(id: String, isDone: Bool)
    case deleteCategory(id: Int)
}

extension TodoRouter: URLRequestConfigurable {
    
    /// API'nin temel URL'si.
    var baseURL: URL? {
        return URL(string: ApiConstants.baseURLString)
    }
    
    /// İstek için kullanılacak URL yolu.
    var path: String {
        switch self {
        case .getTodos:
            return "/get_todos_not_done"
        case .getTodosDone:
            return "/get_todos_done"
        case .addTodo:
            return "/add_todo"
        case .editTodo:
            return "/edit_todo"
        case .deleteTodo:
            return "/delete_todo"
        case .addCategory:
            return "/add_category"
        case .updateCategory:
            return "/edit_category"
        case .deleteCategory:
            return "/delete_category"
        case .updateIsDone:
            return "/update_is_done"
        }
    }
    
    /// HTTP yöntemi.
    var method: HTTPMethod {
        switch self {
        case .getTodos, .getTodosDone:
            return .get
        case .addTodo, .addCategory:
            return .post
        case .editTodo, .updateCategory, .updateIsDone:
            return .put
        case .deleteTodo, .deleteCategory:
            return .delete
        }
    }
    
    /// İstek gövdesine eklenmesi gereken parametreler.
    var bodyParameters: Parameters? {
        switch self {
        case .addTodo(let todoItem):
            return [
                "id": todoItem.id,
                "title": todoItem.title,
                "due_date": todoItem.dueDate,
                "created_date": todoItem.createdDate,
                "is_done": todoItem.isDone,
                "category_id": todoItem.categoryId
            ]
        case .editTodo(let todoItem):
            return [
                "id": todoItem.id,
                "title": todoItem.title,
                "due_date": todoItem.dueDate,
                "is_done": todoItem.isDone,
                "category_id": todoItem.categoryId
            ]
        case .deleteTodo(let id):
                  return ["id": id]
        case .deleteCategory(let id):
            return ["id": id]
        case .addCategory(let categoryName):
            return ["category_name": categoryName]
        case .updateCategory(let id, let categoryName):
            return ["id": id, "category_name": categoryName]
        case .updateIsDone(let id, let isDone):
            return ["id": id, "is_done": isDone]
        default:
            return nil
        }
    }
    
    /// URL'ye eklenmesi gereken parametreler.
    var urlParameters: Parameters? {
            return nil
    }
    
    /// Gövde parametrelerinin nasıl kodlanacağını belirtir.
    var bodyParameterEncoding: BodyParameterEncoding {
        return .jsonEncoding
    }
    
    /// İstek için gerekli olan başlıklar.
    var headers: HTTPHeaders? {
        var headers: [HTTPHeader] = []
        if let jwtToken = UserDefaults.standard.string(forKey: "jwtToken") {
            headers.append(.authorization(bearerToken: jwtToken))
        }
        headers.append(.contentType("application/json"))
        return HTTPHeaders(headers)
    }
    
    /// URLRequest oluşturur ve yapılandırır.
    func asURLRequest() throws -> URLRequest {
        guard let url = baseURL?.appendingPathComponent(path) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        try configure(urlRequest: &urlRequest)
        return urlRequest
    }
}
