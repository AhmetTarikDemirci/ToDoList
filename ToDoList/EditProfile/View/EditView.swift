//
//  EditView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 2.08.2024.
//

import SwiftUI

/// `EditView` yapısı, kullanıcının profil bilgilerini düzenleyebileceği bir form sunar.
///
/// Bu görünüm, kullanıcı adı, e-posta ve şifre gibi bilgilerin düzenlenmesine olanak tanır.
struct EditView: View {
    /// Kullanıcı verilerini yöneten ViewModel.
    @StateObject private var viewModel = UserViewModel()
    
    /// Ana ViewModel, diğer ViewModel'lerle etkileşim sağlar.
    @EnvironmentObject var mainViewModel: MainViewViewModel
    
    /// Düzenlenecek alanın hangisi olduğunu belirten durum.
    @FocusState private var focusedField: Field?
    
    /// Düzenleme türünü belirten enum.
    var editType: EditType
    
    var body: some View {
        VStack {
            Form {
                editFields
                
                /// Kullanıcıdan mevcut şifresini girmesini isteyen alan.
                SecureField("Current Password", text: $viewModel.currentPassword)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .submitLabel(.done)
                    .focused($focusedField, equals: .password)
                    .onSubmit {
                        performUpdate(for: editType)
                    }
                
                /// Güncelleme butonu, düzenleme türüne göre metin ve işlem sağlar.
                TLButton(
                    text: editType.buttonText,
                    backgroundColor: .colorMain,
                    state: .enabled,
                    textWidth: .infinity
                ) {
                    performUpdate(for: editType)
                }
                .padding()
                
                /// Güncelleme işlemi sonrası mesaj gösterimi.
                if viewModel.showMessage {
                    Text(viewModel.message)
                        .foregroundColor(viewModel.messageColor)
                        .padding()
                }
            }
            .padding(.top)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle(editType.title)
    }
    
    /// Düzenleme alanlarını oluşturur, düzenleme türüne göre farklı alanlar sunar.
    @ViewBuilder
    private var editFields: some View {
        switch editType {
        case .username:
            TextField("New Username", text: $viewModel.userName)
                .textFieldStyle(DefaultTextFieldStyle())
                .submitLabel(.next)
                .focused($focusedField, equals: .username)
                .onSubmit {
                    focusedField = .password
                }
                .onAppear {
                    viewModel.userName = mainViewModel.user?.userName ?? ""
                }
            
        case .email:
            TextField("New Email", text: $viewModel.email)
                .textFieldStyle(.automatic)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .password
                }
                .onAppear {
                    viewModel.email = mainViewModel.user?.email ?? ""
                }
            
        case .password:
            SecureField("New Password", text: $viewModel.newPassword)
                .textFieldStyle(DefaultTextFieldStyle())
                .submitLabel(.next)
                .focused($focusedField, equals: .newPassword)
                .onSubmit {
                    focusedField = .password
                }
        }
    }
    
    /// Güncelleme işlemini gerçekleştirir, düzenleme türüne göre uygun ViewModel fonksiyonlarını çağırır.
    ///
    /// - Parameter editType: Düzenleme türü.
    private func performUpdate(for editType: EditType) {
        switch editType {
        case .username:
            viewModel.updateUserName()
            mainViewModel.saveUserName(viewModel.userName)
        case .email:
            viewModel.updateEmail()
            mainViewModel.saveEmail(viewModel.email)
        case .password:
            viewModel.updatePassword()
        }
    }
}

#Preview {
    EditView(editType: .username)
        .environmentObject(MainViewViewModel())
}
