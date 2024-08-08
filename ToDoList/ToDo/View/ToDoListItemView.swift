import SwiftUI

/// `ToDoListItemView` yapısı, yapılacaklar listesi öğelerini görüntülemek için kullanılan bir SwiftUI görünümüdür.
///
/// Bu görünüm, belirli bir görev öğesinin başlığını, son teslim tarihini ve tamamlanma durumunu içerir.
///
/// ### Özellikler
/// - `viewModel`: Görevlerin tamamlanma durumu değişikliklerini yöneten `ToDoListItemViewViewModel`.
/// - `item`: Görev öğesini temsil eden `ToDoListItem`. Görev başlığı, son teslim tarihi, oluşturulma tarihi, tamamlanma durumu ve ait olduğu kategori kimliğini içerir.
/// - `isDeleting`: Görev silme işleminin devam edip etmediğini belirten `Bool` türünde bir değişken.
/// - `onStatusChange`: Görev durumu değiştiğinde çağrılacak tamamlanma bloğu. Bu, görev durumu değişikliklerine yanıt vermek için kullanılabilir.
///
/// ### Görünüm Yapısı
/// - `HStack`: Görev başlığını ve son teslim tarihini yan yana yerleştirir.
///   - `VStack`: Görev başlığını ve son teslim tarihini dikey olarak yerleştirir.
///     - `Text(item.title)`: Görev başlığını gösterir. Yazı tipi kalın olarak ayarlanmıştır.
///     - `Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")`: Görevin son teslim tarihini gösterir. Yazı tipi küçük ve renk ikincil etiket rengindedir.
///   - `Button(action: toggleItemStatus)`: Görev tamamlanma durumu butonu. Butona tıklandığında `toggleItemStatus` işlevi çağrılır ve görevin tamamlanma durumu değiştirilir.
///
/// ### Fonksiyonlar
/// - `toggleItemStatus()`: Görevin tamamlanma durumunu değiştirir.
///   - `isDeleting` değişkenini `true` olarak ayarlar ve animasyon ile `toggleIsDone` işlevini çağırır.
///   - `toggleIsDone` işlevi, `ToDoListItemViewViewModel` içindeki `ApiService`'i kullanarak görevin tamamlanma durumunu günceller.
///   - İşlem başarılı olursa, `item.isDone` değişkenini tersine çevirir ve `onStatusChange` bloğunu çağırır. Aksi halde, hata mesajını yazdırır ve `isDeleting` değişkenini `false` olarak ayarlar.
struct ToDoListItemView: View {
    /// Görevlerin tamamlanma durumu değişikliklerini yöneten ViewModel.
    @StateObject var viewModel = ToDoListItemViewViewModel()
    
    /// Yapılacaklar listesi öğesi.
    @Binding var item: ToDoListItem
    
    /// Silme işleminin devam edip etmediğini belirten durum.
    @Binding var isDeleting: Bool
    
    /// Görev durumu değiştiğinde çağrılacak tamamlanma bloğu.
    var onStatusChange: (() -> Void)?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                /// Görev başlığı.
                Text(item.title)
                    .font(.body)
                    .bold()
                
                /// Görevin son teslim tarihi.
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            .padding(.vertical, 10)
            Spacer()
            
            /// Görev tamamlanma durumu butonu.
            Button(action: toggleItemStatus) {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 1, green: 0.09, blue: 0.27).opacity(0.1))
        .cornerRadius(16)
    }
    
    /// Görevin tamamlanma durumunu değiştirir.
    private func toggleItemStatus() {
        isDeleting = true
        withAnimation {
            viewModel.toggleIsDone(item: item) { result in
                switch result {
                case .success:
                    withAnimation {
                        item.isDone.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            onStatusChange?()
                            isDeleting = false
                        }
                    }
                case .failure(let error):
                    print("Failed to update: \(error)")
                    isDeleting = false
                }
            }
        }
    }
}

#Preview {
    ToDoListItemView(
        item: .constant(ToDoListItem(id: "123", title: "Get milk", dueDate: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, isDone: false, categoryId: 2)),
        isDeleting: .constant(false)
    )
}
