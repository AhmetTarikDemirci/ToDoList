//
//  CompletedTasksViewViewModel.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 31.07.2024.
//

import Foundation

/// `CompletedTasksViewViewModel` sınıfı, tamamlanmış görevleri yönetmek için kullanılan ViewModel'dir.
///
/// Bu sınıf, `ToDoListViewViewModel` sınıfını genişletir ve tamamlanmış görevlerin alınmasını ve yönetilmesini sağlar.
class CompletedTasksViewViewModel: ToDoListViewViewModel {
    /// Tamamlanmış kategoriler.
    @Published var doneCategories: [Category] = []
    
    /// `CompletedTasksViewViewModel` sınıfını başlatır ve varsayılan değerleri ayarlar.
    override init() {
        super.init()
        self.image = "plus.bubble.fill"
        self.title = String(localized: "Complete Mission")
        self.message1 = String(localized: "Once you complete your tasks they will appear on this screen.")
        self.buttonVisible = false
    }

    /// Tekrar deneme işlevi, tamamlanmamış görevleri getirir.
    override func retry() {
        Task {
            await fetchUnCheckedToDos()
        }
    }

    /// Tamamlanmamış görevleri getirir.
    ///
    /// - Note: Bu işlev ana akışta çalışır ve görevlerin durumunu günceller.
    @MainActor
    func fetchUnCheckedToDos() async {
        if !isRefreshable {
            requestState = .loading
        }
        let request = TodoRouter.getTodosDone
        ApiService.shared.request(request, type: [Category].self) { result, statusCode in
            switch result {
            case .success(let response):
                self.doneCategories = response
                self.requestState = response.isEmpty ? .nodata : .success
            case .failure(let error):
                print(error)
                self.requestState = .error(error)
            }
        }
    }

    /// Görevleri belirli bir gecikmeyle yeniler.
    ///
    /// - Note: Bu işlev ana akışta çalışır ve görevlerin durumunu günceller.
    @MainActor
    override func refreshToDosWithDelay() async {
        isRefreshable = true
        await fetchUnCheckedToDos()
    }

    /// Bir kategoriden belirli bir görevi kaldırır.
    ///
    /// - Parameters:
    ///   - categoryId: Kategorinin kimliği.
    ///   - todoId: Görevin kimliği.
    func removeTodoFromCategory(categoryId: Int, todoId: String) {
        if let index = doneCategories.firstIndex(where: { $0.id == categoryId }),
           let todoIndex = doneCategories[index].todos.firstIndex(where: { $0.id == todoId }) {
            doneCategories[index].todos.remove(at: todoIndex)
            showSuccessToast(message:String(localized: "Task marked as not completed"))
            if doneCategories[index].todos.isEmpty {
                doneCategories.remove(at: index)
                
            }

            if doneCategories.isEmpty {
                requestState = .nodata
            }
        }
    }
}
