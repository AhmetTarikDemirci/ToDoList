//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import SwiftUI

/// `ToDoListApp`, uygulamanın ana yapı taşıdır ve uygulama başlatıldığında çalışacak olan `App` protokolünü uygular.
///
/// Bu yapı, uygulamanın ana görünümünü ve tercih edilen renk şemasını ayarlar.
@main
struct ToDoListApp: App {
    /// Kullanıcının seçtiği tema, `Theme` enum'ı kullanılarak saklanır.
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var body: some Scene {
        WindowGroup {
            /// Ana görünüm `MainView` olarak ayarlanır ve kullanıcının tercih ettiği renk şeması uygulanır.
            MainView()
                .preferredColorScheme(userTheme.colorScheme)
        }
    }
}
