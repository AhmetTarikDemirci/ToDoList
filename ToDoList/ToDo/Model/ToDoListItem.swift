//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation

/// `ToDoListItem` yapısı, bir yapılacaklar listesi öğesini temsil eder.
///
/// Bu yapı, belirli bir görev veya yapılacaklar listesi öğesinin bilgilerini içerir.
struct ToDoListItem: Codable, Identifiable {
    /// Görevin benzersiz kimliği.
    let id: String
    
    /// Görevin başlığı.
    let title: String
    
    /// Görevin son teslim tarihi.
    let dueDate: Double
    
    /// Görevin oluşturulma tarihi.
    let createdDate: Double
    
    /// Görevin tamamlanma durumu.
    var isDone: Bool
    
    /// Görevin ait olduğu kategorinin kimliği.
    let categoryId: Int
    
    /// Görevin tamamlanma durumunu ayarlar.
    ///
    /// - Parameter state: Görevin yeni tamamlanma durumu.
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
    
    /// `CodingKeys` enum'u, `ToDoListItem` yapısının kodlanması ve kodunun çözülmesi sırasında kullanılan anahtarları tanımlar.
    enum CodingKeys: String, CodingKey {
        /// Görevin benzersiz kimliği.
        case id
        
        /// Görevin başlığı.
        case title
        
        /// Görevin son teslim tarihi.
        case dueDate = "due_date"
        
        /// Görevin oluşturulma tarihi.
        case createdDate = "created_date"
        
        /// Görevin tamamlanma durumu.
        case isDone = "is_done"
        
        /// Görevin ait olduğu kategorinin kimliği.
        case categoryId = "category_id"
    }
}
