//
//  ContentView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import SwiftUI

/// `MainView` yapısı, uygulamanın ana görünümünü sağlar ve kullanıcının kimlik doğrulama durumuna göre uygun görünümü gösterir.
///
/// Bu görünüm, kullanıcının kimlik doğrulama durumuna göre ya `TabBarView` ya da `LoginView` bileşenini gösterir.
///
/// ### Özellikler
/// - `viewModel`: Kullanıcının kimlik doğrulama durumunu ve kullanıcı bilgilerini yöneten `MainViewViewModel`.
///
/// ### Görünüm Yapısı
/// - `if viewModel.isAuthenticated`: Kullanıcı kimlik doğrulaması yapılmışsa, `TabBarView` görünümünü gösterir.
///   - `TabBarView`: Kullanıcı bilgilerini ve sekme çubuğunu içeren ana görünüm.
///   - `environmentObject(viewModel)`: `viewModel`'i `TabBarView`'a çevresel nesne olarak geçer.
/// - `else`: Kullanıcı kimlik doğrulaması yapılmamışsa, `LoginView` görünümünü gösterir.
struct MainView: View {
    /// Kullanıcının kimlik doğrulama durumunu ve kullanıcı bilgilerini yöneten ViewModel.
    @StateObject private var viewModel = MainViewViewModel()
    
    var body: some View {
        NavigationStack {
                   if viewModel.isAuthenticated {
                       /// Kullanıcı kimlik doğrulaması yapılmışsa, `TabBarView` görünümünü gösterir.
                       TabBarView(user: viewModel.user)
                           .environmentObject(viewModel)
                   } else {
                       /// Kullanıcı kimlik doğrulaması yapılmamışsa, `LoginView` görünümünü gösterir.
                       LoginView()
                   }
               }
        .environmentObject(viewModel)
           }
       }

#Preview {
    MainView()
}
