import SwiftUI

/// `ToDoListView` yapısı, yapılacaklar listesini ve kategorilerini görüntülemek için kullanılan bir SwiftUI görünümüdür.
///
/// Bu görünüm, görevlerin eklenmesi, düzenlenmesi ve silinmesi işlemlerini yönetir.
///
/// ### Özellikler
/// - `viewModel`: Yapılacaklar listesi verilerini yöneten `ToDoListViewViewModel`. Görevlerin ve kategorilerin yönetimini sağlar.
///
/// ### Görünüm Yapısı
/// - `NavigationView`: Ekranın üst kısmında bir başlık ve araç çubuğu sağlayan gezinme görünümü.
/// - `RequestStateController(viewModel: viewModel)`: Görevlerin ve kategorilerin durumu hakkında geri bildirim sağlar.
/// - `ZStack`: Listeleri ve yüklenme göstergelerini üst üste yerleştirir.
///   - `List`: Kategorileri ve kategorilere ait görevleri listeler.
///     - `ForEach($viewModel.categories)`: Kategorileri döngüye alır.
///       - `Section`: Her kategori için bir başlık ve içeriği sağlar.
///         - `if category.todos.isEmpty`: Kategoride görev yoksa yeni görev ekleme butonu gösterir.
///           - `TLButton`: Yeni görev eklemek için kullanılan buton.
///         - `else`: Kategoride görev varsa, görevleri listeler.
///           - `ForEach($category.todos)`: Görevleri döngüye alır.
///             - `ToDoListItemView`: Görev öğesini gösterir.
///             - `swipeActions(edge: .trailing)`: Görev öğesi üzerinde sağa kaydırma hareketiyle ilgili işlemleri sağlar.
///               - `createSwipeActions(for: todo)`: Görevler için sağa kaydırma hareketiyle ilgili işlemleri oluşturur.
///   - `if viewModel.isDeleting`: Silme işlemi devam ederken yüklenme göstergesi.
///     - `ProgressView`: Yüklenme göstergesi.
///
/// ### Fonksiyonlar
/// - `createSwipeActions(for todo: ToDoListItem)`: Görevler için sağa kaydırma hareketiyle ilgili işlemleri oluşturur.
///   - `Button(role: .destructive)`: Görev silme işlemi.
///   - `Button`: Görev düzenleme işlemi.
/// - `createToolbarMenu()`: Toolbar menüsünü oluşturur.
///   - `Menu`: Menü öğelerini içerir.
struct ToDoListView: View {
    /// Yapılacaklar listesi verilerini yöneten ViewModel.
    @StateObject var viewModel = ToDoListViewViewModel()

    var body: some View {
        NavigationView {
            RequestStateController(viewModel: viewModel) {
                ZStack {
                    List {
                        /// Kategorileri ve kategorilere ait görevleri listeler.
                        ForEach($viewModel.categories) { $category in
                            Section(header: Text(category.categoryName)) {
                                /// Kategoride görev yoksa, yeni görev ekleme butonu gösterir.
                                if category.todos.isEmpty {
                                    TLButton(
                                        text: String(localized: "Add a new task"),
                                        backgroundColor: .colorBlue,
                                        state: .enabled,
                                        textWidth: .infinity
                                    ) {
                                        viewModel.presentMenuItemView(with: .addTodo, for: nil, categoryId: category.id)
                                    }
                                    .padding(.horizontal)
                                    .listRowSeparator(.hidden)
                                } else {
                                    /// Kategoride görev varsa, görevleri listeler.
                                    ForEach($category.todos) { $todo in
                                        ToDoListItemView(
                                            item: $todo,
                                            isDeleting: $viewModel.isDeleting
                                        ) {
                                            viewModel.deleteItemFromCategory(categoryId: category.id, todoId: todo.id)
                                           
                                        }
                                        .swipeActions(edge: .trailing) {
                                            createSwipeActions(for: todo)
                                        }
                                        .listRowSeparator(.hidden)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    
                    /// Silme işlemi devam ederken yüklenme göstergesi.
                    if viewModel.isDeleting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.black.opacity(0.4))
                            .edgesIgnoringSafeArea(.all)
                    }
                   
                }
            }
            .refreshable {
                /// Görevleri belirli bir gecikmeyle yeniler.
                await viewModel.refreshToDosWithDelay()
            }
            .navigationTitle("To Do List")
            .toolbar {
                createToolbarMenu()
            }
            .sheet(isPresented: $viewModel.showingMenuItemView) {
                MenuItemView(
                    viewModel: viewModel,
                    newItemPresented: $viewModel.showingMenuItemView,
                    type: viewModel.menuItemType!
                )
                .presentationBackground(.thinMaterial)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
        }
        
        .onAppear {
            /// Görünüm yüklendiğinde yapılacaklar listesini getirir.
                Task {
                    await viewModel.fetchToDos()
                }
            viewModel.clearToast()
            
        }
        .modifier(ToastModifier(toast: $viewModel.toast))
    }
    
    /// Görevler için sağa kaydırma hareketiyle ilgili işlemleri oluşturur.
    ///
    /// - Parameter todo: Kaydırma hareketiyle işlem yapılacak görev.
    @ViewBuilder
    private func createSwipeActions(for todo: ToDoListItem) -> some View {
        Button(role: .destructive) {
            viewModel.deleteItem(itemId: todo.id)
        } label: {
            Label("Delete", systemImage: "trash")
        }
        .tint(.red)
        
        Button {
            viewModel.presentMenuItemView(with: .editTodo, for: todo)
        } label: {
            Label("Edit", systemImage: "pencil")
        }
    }
    
    /// Toolbar menüsünü oluşturur.
    @ViewBuilder
    private func createToolbarMenu() -> some View {
        let buttons: [(String, String, MenuItemType?, Bool)] = [
            (String(localized: "Create Todo"), "rectangle.stack.badge.plus", .addTodo, viewModel.categories.isEmpty),
            (String(localized: "Create Category"), "folder.badge.plus", .addCategory, false),
            (String(localized: "Edit Category"), "folder.badge.gearshape", .editCategory, viewModel.categories.isEmpty),
            (String(localized: "Delete Category"), "trash", .deleteCategory, viewModel.categories.isEmpty)
        ]
        
        Menu {
            ForEach(buttons, id: \.0) { (title, systemImage, type, isDisabled) in
                Button {
                    if let type = type {
                        viewModel.presentMenuItemView(with: type)
                    }
                } label: {
                    Label(title, systemImage: systemImage)
                }
                .disabled(isDisabled)
            }
        } label: {
            Label("Menu", systemImage: "list.dash")
        }
    }
}

#Preview {
    ToDoListView()
}
