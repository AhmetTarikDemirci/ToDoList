//
//  SettingsView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import SwiftUI

/// `SettingsView` yapısı, kullanıcı ayarlarını yönetmek için kullanılan bir görünüm sağlar.
///
/// Bu görünüm, profil düzenleme, tema değiştirme, hesap silme ve çıkış yapma gibi işlemleri içerir.
struct SettingsView: View {
    /// Ayarları yöneten ViewModel.
    @StateObject var viewModel = SettingsViewViewModel()
    
    /// Ana ViewModel, diğer ViewModel'lerle etkileşim sağlar.
    @EnvironmentObject var mainViewModel: MainViewViewModel
    
    /// Geçerli renk şeması.
    @Environment(\.colorScheme) private var scheme
    
    /// Kullanıcı bilgileri.
    var user: User?
    
    var body: some View {
        NavigationView {
            Form {
                profileSection
                settingsSection
                logoutSection
            }
            .navigationBarTitle("Settings")
            .preferredColorScheme(viewModel.userTheme.colorScheme)
            .background(
                NavigationLink(destination: EditProfileView(), isActive: $viewModel.isEditProfileActive) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .sheet(isPresented: $viewModel.changeTheme) {
            ThemeChangeView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        }
        .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Hesabı Silmek İstediğinizden Emin Misiniz?"),
                        message: Text("Bu işlem geri alınamaz."),
                        primaryButton: .destructive(Text("Evet")) {
                            viewModel.deleteAccount(mainViewModel: mainViewModel)
                        },
                        secondaryButton: .cancel(Text("Hayır"))
                    )
                }
       
    }
  
    /// Profil bölümünü oluşturur.
    private var profileSection: some View {
        Group {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text(user?.email ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.background {
                NavigationLink("") {
                    EditProfileView()
                }
            }
        }
    }
    
    /// Ayarlar bölümünü oluşturur.
    private var settingsSection: some View {
        Section("Appearance") {
            HStack {
                Button {
                    viewModel.toggleTheme()
                } label: {
                    Text("Change Theme")
                }
            }
        }
    }
    
    /// Çıkış ve hesap silme bölümünü oluşturur.
    private var logoutSection: some View {
        Section {
            Button {
                viewModel.showAlert = true
                
            } label: {
                Text("Permanently Delete Account")
                    .foregroundColor(.red)
            }
            
            Button {
                viewModel.logout(mainViewModel: mainViewModel)
            } label: {
                Text("Logout")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    SettingsView()
}
