import SwiftUI

/// `CompletedTasksView` yapısı, tamamlanmış görevleri listeleyen bir görünüm sağlar.
///
/// Bu görünüm, `CompletedTasksViewViewModel`'i kullanarak tamamlanmış görevleri yönetir ve görüntüler.
///
/// ### Özellikler
/// - `viewModel`: Tamamlanmış görevleri yöneten `CompletedTasksViewViewModel`.
///
/// ### Görünüm Yapısı
/// - `NavigationView`: Ekranın üst kısmında bir başlık ve araç çubuğu sağlayan gezinme görünümü.
/// - `RequestStateController(viewModel: viewModel)`: Görevlerin ve kategorilerin durumu hakkında geri bildirim sağlar.
/// - `ZStack`: Listeleri ve yüklenme göstergelerini üst üste yerleştirir.
///   - `List`: Kategorileri ve kategorilere ait görevleri listeler.
///     - `ForEach($viewModel.doneCategories)`: Kategorileri döngüye alır.
///       - `Section`: Her kategori için bir başlık ve içeriği sağlar.
///         - `ForEach($category.todos)`: Görevleri döngüye alır.
///           - `ToDoListItemView`: Görev öğesini gösterir.
///           - `listRowSeparator(.hidden)`: Satır ayırıcıyı gizler.
///   - `if viewModel.isDeleting`: Silme işlemi devam ederken yüklenme göstergesi.
///     - `ProgressView`: Yüklenme göstergesi.
///
/// ### Yenileme
/// - `refreshable`: Görevleri belirli bir gecikmeyle yeniler.
///
/// ### Görünüm Yüklendiğinde
/// - `onAppear`: Görünüm yüklendiğinde tamamlanmamış görevlerin getirilmesi.
struct CompletedTasksView: View {
    /// Tamamlanmış görevleri yöneten ViewModel.
    @StateObject var viewModel = CompletedTasksViewViewModel()
    
    var body: some View {
        NavigationView {
            RequestStateController(viewModel: viewModel) {
                ZStack {
                    List {
                        /// Tamamlanmış görevlerin kategorilere göre listelenmesi.
                        ForEach($viewModel.doneCategories) { $category in
                            Section(header: Text(category.categoryName)) {
                                /// Her kategori için görevlerin listelenmesi.
                                ForEach($category.todos) { $todo in
                                    ToDoListItemView(item: $todo, isDeleting: $viewModel.isDeleting) {
                                        viewModel.removeTodoFromCategory(categoryId: category.id, todoId: todo.id)
                                    }
                                    .listRowSeparator(.hidden)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    
                    /// Görev silme işlemi sırasında gösterilen yüklenme göstergesi.
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
                Task {
                    await viewModel.refreshToDosWithDelay()
                }
            }
            .navigationTitle("Completed Tasks")
        }
        .onAppear {
            /// Görünüm yüklendiğinde tamamlanmamış görevlerin getirilmesi.
                Task {
                    await viewModel.fetchUnCheckedToDos()
                }
            viewModel.clearToast()
        }
        .modifier(ToastModifier(toast: $viewModel.toast))
    }
}

#Preview {
    CompletedTasksView()
}
