//
//  TabBarView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import SwiftUI

/// `TabBarView`, uygulamanın tab bar arayüzünü temsil eder.
///
/// Bu görünüm, kullanıcıların yapılacaklar listesine, tamamlanmış görevlere ve ayar sayfasına erişmesini sağlar.
struct TabBarView: View {
    /// Kullanıcı bilgilerini içeren opsiyonel değişken.
    var user: User?
    
    var body: some View {
        TabView {
            /// Yapılacaklar listesi görünümü.
            ToDoListView()
                .tabItem {
                    Image(systemName: "checklist.unchecked")
                    Text(LocalizedStringKey("UnChecked"))
                }
                .tag(0)
            
            /// Tamamlanmış görevler görünümü.
            CompletedTasksView()
                .tabItem {
                    Image(systemName: "checklist.checked")
                    Text(LocalizedStringKey("Checked"))
                }
                .tag(1)
            
            /// Ayarlar görünümü. Kullanıcı bilgilerini alır.
            SettingsView(user: user)
                .tabItem {
                    Image(systemName: "gear")
                    Text(LocalizedStringKey("Settings"))
                }
                .tag(2)
        }
    }
}

#Preview {
    TabBarView()
}
