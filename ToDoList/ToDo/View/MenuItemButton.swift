//
//  MenuItemButton.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 28.07.2024.
//

import SwiftUI

/// `MenuItemButton` yapısı, yapılacaklar listesi veya kategori eklemek, düzenlemek veya silmek için bir buton sunar.
///
/// Bu görünüm, belirli bir `MenuItemType`'a göre işlem yapar ve `ToDoListViewViewModel`'i gözlemler.
struct MenuItemButton: View {
    /// ToDoListViewViewModel'ini gözlemler.
    @ObservedObject var viewModel: ToDoListViewViewModel
    
    /// Yeni öğe sunumunu kontrol eden bağlanmış değişken.
    @Binding var newItemPresented: Bool
    
    /// Menü öğesi türü.
    var type: MenuItemType
    
    /// Menü öğesi kimliği (varsayılan: `nil`).
    var id: String?
    
    var body: some View {
        TLButton(
            text: type.buttonText,
            backgroundColor: .colorMain,
            state: .enabled,
            textWidth: .infinity,
            isRequesting: viewModel.buttonState
        ) {
            performAction(for: type)
        }
        .onChange(of: viewModel.buttonState) { newValue in
            if !newValue {
                newItemPresented = false
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(LocalizedStringKey("Error")),
                message: Text(LocalizedStringKey("Please fill in all fields and select a due date that is today or newer"))
            )
        }
        .padding()
    }
    
    /// Belirtilen `MenuItemType`'a göre ilgili işlemi gerçekleştirir.
    ///
    /// - Parameter type: Menü öğesi türü.
    private func performAction(for type: MenuItemType) {
        switch type {
        case .addTodo, .editTodo:
            if viewModel.canSave {
                type == .addTodo ? viewModel.addTodo() : viewModel.editTodo()
            } else {
                viewModel.showAlert = true
            }
        case .addCategory, .editCategory:
            if viewModel.canSaveCategory {
                type == .addCategory ? viewModel.addCategory() : viewModel.editCategory()
            } else {
                viewModel.showAlert = true
            }
        case .deleteCategory:
            viewModel.deleteCategory()
        }
    }
}

#Preview {
    MenuItemButton(
        viewModel: ToDoListViewViewModel(),
        newItemPresented: .constant(true),
        type: .editTodo
    )
}
