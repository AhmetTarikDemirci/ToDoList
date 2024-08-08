//
//  ToDoListItemViewViewModel.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation

/// `ToDoListItemViewViewModel` sınıfı, yapılacaklar listesi öğeleri için ViewModel işlevselliği sağlar.
///
/// Bu sınıf, görevlerin tamamlanma durumunu günceller.
class ToDoListItemViewViewModel: BaseViewModel {
    /// `ToDoListItemViewViewModel` sınıfını başlatır.
    override init() {}
    
    /// Görevin tamamlanma durumunu değiştirir.
    ///
    /// - Parameters:
    ///   - item: Tamamlanma durumu değiştirilecek görev.
    ///   - completion: Tamamlanma durumunun değiştirildiğini bildiren tamamlanma bloğu.
    func toggleIsDone(item: ToDoListItem, completion: @escaping (Result<Void, Error>) -> Void) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        ApiService.shared.request(TodoRouter.updateIsDone(id: item.id, isDone: itemCopy.isDone), type: ApiResponse.self) { result, statusCode in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
