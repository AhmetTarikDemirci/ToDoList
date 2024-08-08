//
//  TLTextField.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 28.07.2024.
//

import SwiftUI

/// `TLTextField` yapısı, kullanıcıdan metin girişi almak için özelleştirilmiş bir metin alanı sağlar.
///
/// Bu görünüm, bir başlık ve bağlanmış metin değeri ile bir metin alanı oluşturur.
///
/// ### Kullanım Örneği
/// ```
/// struct ContentView: View {
///     @State private var metin: String = ""
///
///     var body: some View {
///         TLTextField(text: $metin, title: "Başlık")
///     }
/// }
/// ```
///
/// - Parameters:
///   - text: Kullanıcının girdiği metni bağlayan `Binding<String>` değişken.
///   - title: Metin alanının başlığı.
struct TLTextField: View {
    /// Kullanıcının girdiği metni bağlayan değişken.
    @Binding var text: String
    
    /// Metin alanının başlığı.
    var title: String
    
    var body: some View {
        TextField(title, text: $text)
            .textFieldStyle(.automatic)
    }
}

#Preview {
    TLTextField(text: .constant("Dene"), title: "Deneme")
}
