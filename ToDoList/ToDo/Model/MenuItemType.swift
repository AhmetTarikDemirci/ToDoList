//
//  MenuItemType.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 28.07.2024.
//

import Foundation
import SwiftUI

/// `MenuItemType` enum'u, yapılacaklar listesi veya kategori ekleme, düzenleme veya silme işlemlerini tanımlar.
///
/// Bu enum, farklı işlem türleri için başlık, buton metni ve metin alanı prompt'u sağlar.
enum MenuItemType {
    /// Yapılacaklar listesine öğe ekleme.
    case addTodo
    
    /// Yapılacaklar listesindeki öğeyi düzenleme.
    case editTodo
    
    /// Kategori ekleme.
    case addCategory
    
    /// Kategoriyi düzenleme.
    case editCategory
    
    /// Kategoriyi silme.
    case deleteCategory
    
    /// İşlem türüne göre başlık metnini döndürür.
    ///
    /// - Returns: İşlem türüne göre lokalize edilmiş başlık metni.
    var title: String {
        switch self {
        case .addTodo:
            return String(localized: "Add Todo")
        case .editTodo:
            return String(localized: "Edit Todo")
        case .addCategory:
            return String(localized: "Add Category")
        case .editCategory:
            return String(localized: "Edit Category")
        case .deleteCategory:
            return String(localized: "Delete Category")
        }
    }
    
    /// İşlem türüne göre buton metnini döndürür.
    ///
    /// - Returns: İşlem türüne göre lokalize edilmiş buton metni.
    var buttonText: String {
        switch self {
        case .addTodo, .addCategory:
            return String(localized: "Save")
        case .editTodo, .editCategory:
            return String(localized: "Update")
        case .deleteCategory:
            return String(localized: "Done")
        }
    }
    
    /// İşlem türüne göre metin alanı prompt'unu döndürür.
    ///
    /// - Returns: İşlem türüne göre lokalize edilmiş metin alanı prompt'u.
    var textFieldPrompt: String {
        switch self {
        case .addTodo, .editTodo:
            return String(localized: "To Do Title")
        case .addCategory, .editCategory, .deleteCategory:
            return String(localized: "Category Name")
        }
    }
}
