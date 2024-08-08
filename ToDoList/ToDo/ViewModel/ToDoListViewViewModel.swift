//
//  ToDoListViewViewModel.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation
import SwiftUI

/// `ToDoListViewViewModel` sınıfı, yapılacaklar listesi ve kategoriler için ViewModel işlevselliği sağlar.
///
/// Bu sınıf, görevlerin ve kategorilerin yönetimini, ekleme, düzenleme ve silme işlemlerini gerçekleştirir.
class ToDoListViewViewModel: BaseViewModel {
    /// Kullanıcının girdiği yapılacaklar listesi başlığı.
    @Published var toDoTitle = ""
    
    /// Kullanıcının girdiği kategori adı.
    @Published var categoryName = ""
    
    /// Yapılacak işin son teslim tarihi.
    @Published var dueDate = Date()
    
    /// Seçilen kategorinin kimliği.
    @Published var categoryId: Int? = nil
    
    /// Uyarı mesajının gösterilip gösterilmeyeceğini belirten durum.
    @Published var showAlert = false
    
    /// Menü öğesi görünümünün gösterilip gösterilmeyeceğini belirten durum.
    @Published var showingMenuItemView = false
    
    /// Geçerli menü öğesi türü.
    @Published var menuItemType: MenuItemType?
    
    /// Geçerli yapılacaklar listesi öğesi.
    @Published var currentTodo: ToDoListItem?
    
    /// Kategoriler listesi.
    @Published var categories: [Category] = []
    
    /// Silme işleminin devam edip etmediğini belirten durum.
    @Published var isDeleting: Bool = false
    
    /// `ToDoListViewViewModel` sınıfını başlatır ve varsayılan değerleri ayarlar.
    override init() {
        super.init()
        self.image = "plus.bubble.fill"
        self.title = String(localized: "Let's Start Adding Tasks")
        self.message1 = String(localized: "When you have tasks, they will appear on this screen.")
        self.buttonText = String(localized: "Let's start!")
        self.buttonColor = .blue
        self.buttonVisible = true
        self.action = {
            self.presentMenuItemView(with: .addCategory)
        }
    }
    /// Tekrar deneme işlevi, görevleri yeniden getirir.
    override func retry() {
        Task {
            await fetchToDos()
        }
    }
    
    /// Menü öğesi görünümünü sunar.
    ///
    /// - Parameters:
    ///   - type: Menü öğesi türü.
    ///   - todo: Düzenlenecek görev (varsayılan: `nil`).
    ///   - categoryId: Seçilen kategorinin kimliği (varsayılan: `nil`).
    func presentMenuItemView(with type: MenuItemType, for todo: ToDoListItem? = nil, categoryId: Int? = nil) {
        self.menuItemType = type
        self.showingMenuItemView = true
        self.categoryId = categoryId
        self.currentTodo = todo
        if let todo = todo {
            self.toDoTitle = todo.title
            self.dueDate = Date(timeIntervalSince1970: todo.dueDate)
            self.categoryId = todo.categoryId
        }
    }
    
    /// Menü öğesi görünümünü kapatır.
    func dismissMenuItemView() {
        self.showingMenuItemView = false
        self.menuItemType = nil
        resetFields()
    }
    
    /// Alanları varsayılan değerlere sıfırlar.
    func resetFields() {
        self.toDoTitle = ""
        self.categoryName = ""
        self.dueDate = Date()
        self.categoryId = nil
    }
    
    /// Yapılacaklar listesini getirir.
    ///
    /// Bu işlev ana akışta çalışır ve görevlerin durumunu günceller.
    @MainActor
    func fetchToDos() async {
        if !isRefreshable {
            requestState = .loading
        }
        let request = TodoRouter.getTodos
        ApiService.shared.request(request, type: [Category].self) { result, statusCode in
            switch result {
            case .success(let response):
                self.categories = response
                self.requestState = response.isEmpty ? .nodata : .success
                self.isRefreshable = false
            case .failure(let error):
                print(error)
                self.requestState = .error(error)
            }
        }
    }
    
    /// Görevleri belirli bir gecikmeyle yeniler.
    ///
    /// Bu işlev ana akışta çalışır ve görevlerin durumunu günceller.
    @MainActor
    func refreshToDosWithDelay() async {
        isRefreshable = true
        await fetchToDos()
    }
    
    /// Yeni bir yapılacaklar listesi öğesi ekler.
    func addTodo() {
        guard canSave else { return }
        buttonState = true
        let todoItem = ToDoListItem(
            id: UUID().uuidString,
            title: toDoTitle,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false,
            categoryId: categoryId ?? 0
        )
        ApiService.shared.request(TodoRouter.addTodo(todoItem: todoItem), type: ToDoListItem.self) { [self] result, statusCode in
            switch result {
            case .success(let newTodoItem):
                if let categoryIndex = categories.firstIndex(where: { $0.id == self.categoryId }) {
                    self.categories[categoryIndex].todos.append(newTodoItem)
                }
                self.requestState = self.categories.isEmpty ? .nodata : .success
                self.resetFields()
                self.buttonState = false
            case .failure(let error):
                print("Error: \(error)")
                self.buttonState = false
            }
        }
    }
    
    /// Yeni bir kategori ekler.
    func addCategory() {
        guard canSaveCategory else { return }
        buttonState = true
        let request = TodoRouter.addCategory(categoryName: categoryName)
        ApiService.shared.request(request, type: Category.self) { result, statusCode in
            switch result {
            case .success(let response):
                self.categories.append(response)
                self.requestState = self.categories.isEmpty ? .nodata : .success
                self.resetFields()
                self.buttonState = false
            case .failure(let error):
                print("Error: \(error)")
                self.buttonState = false
            }
        }
    }
    
    /// Yapılacaklar listesi öğesinin düzenlenmesini sağlar.
    func editTodo() {
        guard let todo = currentTodo, canSave else { return }
        buttonState = true
        let todoItem = ToDoListItem(
            id: todo.id,
            title: toDoTitle,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false,
            categoryId: categoryId ?? 0
        )
        let request = TodoRouter.editTodo(todoItem: todoItem)
        ApiService.shared.request(request, type: ApiResponse.self) { result, statusCode in
            switch result {
            case .success:
                if let categoryIndex = self.categories.firstIndex(where: { $0.id == todoItem.categoryId }),
                   let todoIndex = self.categories[categoryIndex].todos.firstIndex(where: { $0.id == todoItem.id }) {
                    self.categories[categoryIndex].todos[todoIndex] = todoItem
                }
                self.buttonState = false
            case .failure(let error):
                print("Error: \(error)")
                self.buttonState = false
            }
        }
    }
    
    /// Kategoriyi düzenler.
    func editCategory() {
        guard canSaveCategory, let categoryId = categoryId else { return }
        buttonState = true
        let request = TodoRouter.updateCategory(id: categoryId, categoryName: categoryName)
        ApiService.shared.request(request, type: Category.self) { result, statusCode in
            switch result {
            case .success(let updatedCategory):
                if let index = self.categories.firstIndex(where: { $0.id == updatedCategory.id }) {
                    self.categories[index] = updatedCategory
                    self.resetFields()
                }
                self.buttonState = false
            case .failure(let error):
                print("Error: \(error)")
                self.buttonState = false
            }
        }
    }
    
    /// Kategoriyi siler.
    func deleteCategory() {
        guard let categoryId = categoryId else { return }
        buttonState = true
        let request = TodoRouter.deleteCategory(id: categoryId)
        ApiService.shared.request(request, type: ApiResponse.self) { result, statusCode in
            switch result {
            case .success:
                if let index = self.categories.firstIndex(where: { $0.id == categoryId }) {
                    self.categories.remove(at: index)
                }
                self.requestState = self.categories.isEmpty ? .nodata : .success
                self.buttonState = false
            case .failure(let error):
                print("Error: \(error)")
                self.buttonState = false
            }
        }
    }
    
    /// Belirli bir kategori içindeki görev öğesini siler.
    ///
    /// - Parameters:
    ///   - categoryId: Kategorinin kimliği.
    ///   - todoId: Görevin kimliği.
    func deleteItemFromCategory(categoryId: Int, todoId: String) {
        if let index = categories.firstIndex(where: { $0.id == categoryId }),
           let todoIndex = categories[index].todos.firstIndex(where: { $0.id == todoId }) {
            categories[index].todos.remove(at: todoIndex)
            showSuccessToast(message: String(localized:"Mission completed successfully"))
        }
    }
    
    /// Belirli bir görev öğesini siler.
    ///
    /// - Parameter itemId: Görevin kimliği.
    func deleteItem(itemId: String) {
        let request = TodoRouter.deleteTodo(id: itemId)
        ApiService.shared.request(request, type: ApiResponse.self) { result, statusCode in
            switch result {
            case .success(let response):
                if let categoryIndex = self.categories.firstIndex(where: { $0.todos.contains(where: { $0.id == itemId }) }) {
                    if let todoIndex = self.categories[categoryIndex].todos.firstIndex(where: { $0.id == itemId }) {
                        self.categories[categoryIndex].todos.remove(at: todoIndex)
                    }
                }
                self.showSuccessToast(message: response.message ?? "")
            case .failure(let error):
                print("Error: \(error)")
                self.showErrorToast(message: error.asApiError.description)
            }
        }
    }
    
    /// Görevin kaydedilebilir olup olmadığını belirten durum.
    var canSave: Bool {
        !toDoTitle.trimmingCharacters(in: .whitespaces).isEmpty && dueDate >= Date().addingTimeInterval(-86400)
    }
    
    /// Kategorinin kaydedilebilir olup olmadığını belirten durum.
    var canSaveCategory: Bool {
        !categoryName.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
