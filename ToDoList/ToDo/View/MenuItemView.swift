import SwiftUI

/// `MenuItemView` yapısı, yapılacaklar listesi veya kategori ekleme, düzenleme ve silme işlemleri için kullanılan bir görünümdür.
///
/// Bu görünüm, `ToDoListViewViewModel` ve `MenuItemType` kullanarak uygun form bileşenlerini görüntüler.
///
/// ### Özellikler
/// - `viewModel`: Yapılacaklar listesi verilerini yöneten `ToDoListViewViewModel`.
/// - `newItemPresented`: Yeni bir öğenin sunulup sunulmadığını belirten binding değişkeni.
/// - `type`: Menü öğesi türünü belirten `MenuItemType`.
///
/// ### Görünüm Yapısı
/// - `VStack`: Üstte bir başlık ve form bileşenlerini içerir.
///   - `Text(type.title)`: Menü öğesi türüne göre başlığı gösterir.
///   - `Form`: Form bileşenlerini içerir.
///     - `categoryPickerView`: Kategori seçici bileşen.
///     - `textFieldView`: Metin alanı bileşeni.
///     - `datePickerView`: Tarih seçici bileşeni.
///     - `MenuItemButton`: Menü öğesi türüne göre ilgili butonu gösterir.
///
/// ### Fonksiyonlar
/// - `binding(for:type:)`: Menü öğesi türüne göre uygun binding değerini döndürür.
struct MenuItemView: View {
    /// Yapılacaklar listesi verilerini yöneten ViewModel.
    @ObservedObject var viewModel: ToDoListViewViewModel
    
    /// Yeni bir öğenin sunulup sunulmadığını belirten binding değişkeni.
    @Binding var newItemPresented: Bool
    
    /// Menü öğesi türünü belirten değişken.
    var type: MenuItemType
    
    var body: some View {
        VStack {
            /// Menü öğesi türüne göre başlığı gösterir.
            Text(type.title)
                .font(.system(size: 32).bold())
                .padding(.top, 30)
            
            Form {
                /// Kategori seçici bileşen.
                categoryPickerView
                
                /// Metin alanı bileşeni.
                textFieldView
                
                /// Tarih seçici bileşeni.
                datePickerView
                
                /// Menü öğesi türüne göre ilgili butonu gösterir.
                MenuItemButton(viewModel: viewModel, newItemPresented: $newItemPresented, type: type)
            }
            .scrollContentBackground(.hidden)
        }
    }
    
    /// Menü öğesi türüne göre kategori seçici bileşeni gösterir.
    @ViewBuilder
    private var categoryPickerView: some View {
        if type != .addCategory {
            CategoryPickerView(viewModel: viewModel)
        }
    }
    
    /// Menü öğesi türüne göre metin alanı bileşenini gösterir.
    @ViewBuilder
    private var textFieldView: some View {
        if type != .deleteCategory {
            TLTextField(text: binding(for: type, viewModel: viewModel), title: type.textFieldPrompt)
        }
    }
    
    /// Menü öğesi türüne göre tarih seçici bileşenini gösterir.
    @ViewBuilder
    private var datePickerView: some View {
        if type != .addCategory && type != .editCategory && type != .deleteCategory {
            DatePicker("Due Date", selection: $viewModel.dueDate)
                .datePickerStyle(.graphical)
        }
    }
    
    /// Menü öğesi türüne göre uygun binding değerini döndürür.
    ///
    /// - Parameters:
    ///   - type: Menü öğesi türü.
    ///   - viewModel: Yapılacaklar listesi verilerini yöneten ViewModel.
    /// - Returns: Uygun binding değeri.
    private func binding(for type: MenuItemType, viewModel: ToDoListViewViewModel) -> Binding<String> {
        switch type {
        case .addTodo, .editTodo:
            return $viewModel.toDoTitle
        case .addCategory, .editCategory, .deleteCategory:
            return $viewModel.categoryName
        }
    }
}

#Preview {
    MenuItemView(viewModel: ToDoListViewViewModel(), newItemPresented: .constant(true), type: .addTodo)
}
