//
//  ToastModifier.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 5.08.2024.
//

import SwiftUI

/// İçerik görünümünün üzerine bir bildirim (toast) mesajı yerleştiren bir görünüm değiştirici.
///
/// Bu değiştirici, belirli bir süre boyunca ekranın alt kısmında bir bildirim mesajı göstermenizi sağlar.
/// Bildirim mesajı manuel olarak veya belirli bir süre sonra otomatik olarak kapatılabilir.
///
/// Örnek kullanım:
/// ```
/// struct ContentView: View {
///     @State private var toast: Toast?
///
///     var body: some View {
///         VStack {
///             Button("Bildirim Göster") {
///                 toast = Toast(
///                     style: .success,
///                     message: "Bu bir bildirim mesajıdır!",
///                     width: 300,
///                     duration: 2.0
///                 )
///             }
///         }
///         .modifier(ToastModifier(toast: $toast))
///     }
/// }
/// ```
struct ToastModifier: ViewModifier {
    /// Gösterilecek bildirim mesajını bağlayan değişken.
    @Binding var toast: Toast?

    /// Süre dolduktan sonra bildirimi kapatmaktan sorumlu olan çalışma öğesi.
    @State private var workItem: DispatchWorkItem?

    /// İçerik görünümünün üzerine bildirim mesajını yerleştiren görünümün gövdesi.
    ///
    /// - Parameter content: Bildirim yerleştirilecek içerik görünümü.
    /// - Returns: Bildirim mesajını içerik görünümünün üzerine yerleştiren bir görünüm.
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    VStack {
                        Spacer()
                        mainToastView()
                    }
                }
                .animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }

    /// Bildirim mesajını gösteren ana görünüm.
    ///
    /// Bu görünüm oluşturucu işlevi, bir bildirim mesajı varsa bir `ToastView` döner.
    /// `ToastView` ekranın altında bir dolgu ile gösterilir.
    ///
    /// - Returns: Bildirim mesajını gösteren bir görünüm.
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            ToastView(
                style: toast.style,
                message: toast.message,
                width: toast.width
            ) {
                print("Çalıştı dismiss")
                dismissToast()
            }
            .padding(.bottom, 32)
        }
    }

    /// Bildirim mesajını titreşimli geri bildirim ile gösterir.
    ///
    /// Bu işlev, bildirim mesajı gösterildiğinde hafif bir titreşim geri bildirimi tetikler.
    /// Eğer bildirim süresi 0'dan büyükse, belirtilen süre sonra bildirimi kapatmak için bir görev zamanlar.
    private func showToast() {
        guard let toast = toast else { return }

        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()

        if toast.duration > 0 {
            workItem?.cancel()

            let task = DispatchWorkItem {
                dismissToast()
            }

            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }

    /// Animasyonlu olarak bildirim mesajını kapatır.
    ///
    /// Bu işlev, animasyon ile `toast` bağını `nil` olarak ayarlar
    /// ve bekleyen herhangi bir çalışma öğesini iptal eder.
    private func dismissToast() {
        withAnimation {
            toast = nil
        }

        workItem?.cancel()
        workItem = nil
    }
}
