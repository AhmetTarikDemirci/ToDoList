//
//  Category.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 27.07.2024.
//

import Foundation

/// `Category` yapısı, bir yapılacaklar listesi kategorisini temsil eder.
///
/// Bu yapı, belirli bir kategoriye ait görevleri yönetmek için kullanılır.
struct Category: Identifiable, Codable {
    /// Kategorinin benzersiz kimliği.
    let id: Int
    
    /// Kategorinin adı.
    var categoryName: String
    
    /// Kategoriye ait yapılacaklar listesi öğeleri.
    var todos: [ToDoListItem]

    /// `CodingKeys` enum'u, `Category` yapısının kodlanması ve kodunun çözülmesi sırasında kullanılan anahtarları tanımlar.
    enum CodingKeys: String, CodingKey {
        /// Kategorinin benzersiz kimliği.
        case id
        
        /// Kategorinin adı.
        case categoryName = "category_name"
        
        /// Kategoriye ait yapılacaklar listesi öğeleri.
        case todos
    }
}
