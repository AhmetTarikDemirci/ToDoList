//
//  LoginView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import SwiftUI

/// `LoginView` yapısı, kullanıcıların giriş yapmasını sağlayan bir SwiftUI görünümüdür.
///
/// Bu görünüm, kullanıcıların e-posta ve şifre bilgilerini girerek giriş yapmalarını sağlar ve başarılı girişlerde ana görünüme yönlendirir.
///
/// ### Özellikler
/// - `viewModel`: Giriş işlemlerini yöneten `LoginViewViewModel`.
/// - `focusedField`: Odaklanılan form alanını belirten `FocusState`.
///
/// ### Görünüm Yapısı
/// - `NavigationView`: Ana gezinme görünümü.
/// - `VStack`: Giriş formunu ve diğer bileşenleri dikey olarak düzenler.
///   - `HeaderView`: Başlık ve alt başlığı içeren üst kısım.
///   - `Form`: Giriş formunu içeren kısım.
///     - `errorMessageView`: Hata mesajını gösteren metin.
///     - `emailField`: E-posta adresi giriş alanı.
///     - `passwordField`: Şifre giriş alanı.
///     - `TLButton`: Giriş butonu.
///   - `VStack`: Yeni kullanıcı kaydı için bağlantılar.
///     - `Text`: Yeni kullanıcı metni.
///     - `NavigationLink`: Kayıt olma görünümüne bağlantı.
///
/// ### Fonksiyonlar
/// - `errorMessageView`: Hata mesajını gösteren alt görünüm.
/// - `emailField`: E-posta adresi giriş alanını döndüren alt görünüm.
/// - `passwordField`: Şifre giriş alanını döndüren alt görünüm.
struct LoginView: View {
    /// Giriş işlemlerini yöneten ViewModel.
    @StateObject var viewModel = LoginViewViewModel()
    
    /// Odaklanılan form alanını belirten `FocusState`.
    @FocusState private var focusedField: Field?
    
    var body: some View {
            VStack {
                /// Başlık ve alt başlığı içeren üst kısım.
                HeaderView(title: String(localized: "To Do List"),
                           subTitle: String(localized: "Get things done"),
                           angle: 15,
                           background: .pink)
                
                Form {
                    /// Hata mesajını gösteren metin.
                    errorMessageView
                    /// E-posta adresi giriş alanı.
                    emailField
                    /// Şifre giriş alanı.
                    passwordField
                    
                    /// Giriş butonu.
                    TLButton(text: String(localized: "Log In"),
                             backgroundColor: .blue,
                             state: .enabled,
                             textWidth: .infinity,
                             isRequesting:viewModel.buttonState) {
                        viewModel.login()
                    }
                             .padding()
                }
                .offset(y: -50)
                .scrollContentBackground(.hidden)
                
                VStack {
                    Text("New around here?")
                    NavigationLink("Create An Account", destination: RegisterView())
                }
                .padding(.bottom, 50)
            }
            .ignoresSafeArea(.keyboard)
            .fullScreenCover(isPresented: $viewModel.isAuthenticated) {
                MainView()
            }
        
    }
    
    /// Hata mesajını gösteren alt görünüm.
    @ViewBuilder
    private var errorMessageView: some View {
        if !viewModel.errorMessage.isEmpty {
            Text(viewModel.errorMessage)
                .foregroundStyle(.red)
        }
    }
    
    /// E-posta adresi giriş alanını döndüren alt görünüm.
    private var emailField: some View {
        TextField("Email Address", text: $viewModel.email)
            .textFieldStyle(.automatic)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .submitLabel(.next)
            .focused($focusedField, equals: .email)
            .onSubmit {
                focusedField = .password
            }
    }
    
    /// Şifre giriş alanını döndüren alt görünüm.
    private var passwordField: some View {
        SecureField("Password", text: $viewModel.password)
            .textFieldStyle(.automatic)
            .submitLabel(.done)
            .focused($focusedField, equals: .password)
            .onSubmit {
                viewModel.login()
            }
    }
}

#Preview {
    LoginView()
}
