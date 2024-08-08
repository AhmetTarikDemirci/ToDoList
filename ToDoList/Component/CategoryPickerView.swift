//
//  CategoryPickerView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 28.07.2024.
//

import SwiftUI

/// `CategoryPickerView` yapısı, kullanıcının bir kategori seçmesine olanak tanıyan bir picker bileşenidir.
///
/// Bu görünüm, kategorileri `ToDoListViewViewModel` üzerinden alır ve kullanıcının seçimine göre kategori kimliğini günceller.
///
/// ### Kullanım Örneği
/// ```
/// struct ContentView: View {
///     @ObservedObject var viewModel = ToDoListViewViewModel()
///
///     var body: some View {
///         CategoryPickerView(viewModel: viewModel)
///     }
/// }
/// ```
///
/// - Parameters:
///   - viewModel: `ToDoListViewViewModel` tipinde gözlemlenen bir nesne. Kategorileri ve seçilen kategori kimliğini yönetir.
struct CategoryPickerView: View {
    /// ToDoListViewViewModel'ini gözlemler.
    @ObservedObject var viewModel: ToDoListViewViewModel
    
    var body: some View {
        Picker(selection: $viewModel.categoryId, label: Text(LocalizedStringKey("Category"))) {
            /// Kategori seçimi için varsayılan seçenek.
            Text(LocalizedStringKey("Select a Category")).tag(nil as Int?)
            
            /// Kategorileri listeleyen seçenekler.
            ForEach(viewModel.categories) { category in
                Text(category.categoryName).tag(category.id as Int?)
            }
        }
    }
}

#Preview {
    CategoryPickerView(viewModel: ToDoListViewViewModel())
}
