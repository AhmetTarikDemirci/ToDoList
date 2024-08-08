//
//  RegisterView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import SwiftUI

/// `RegisterView` yapısı, kullanıcıların kayıt olmasını sağlayan bir SwiftUI görünümüdür.
///
/// Bu görünüm, kullanıcıların ad, e-posta ve şifre bilgilerini girerek kayıt yapmalarını sağlar ve başarılı kayıt işlemlerinde ana görünüme yönlendirir.
///
/// ### Özellikler
/// - `viewModel`: Kayıt işlemlerini yöneten `RegisterViewViewModel`.
/// - `focusedField`: Odaklanılan form alanını belirten `FocusState`.
///
/// ### Görünüm Yapısı
/// - `VStack`: Kayıt formunu ve diğer bileşenleri dikey olarak düzenler.
///   - `HeaderView`: Başlık ve alt başlığı içeren üst kısım.
///   - `Form`: Kayıt formunu içeren kısım.
///     - `errorMessageView`: Hata mesajını gösteren metin.
///     - `usernameField`: Kullanıcı adı giriş alanı.
///     - `emailField`: E-posta adresi giriş alanı.
///     - `passwordField`: Şifre giriş alanı.
///     - `TLButton`: Kayıt butonu.
///   - `Spacer`: Alt kısmı doldurur.
///
/// ### Fonksiyonlar
/// - `errorMessageView`: Hata mesajını gösteren alt görünüm.
/// - `usernameField`: Kullanıcı adı giriş alanını döndüren alt görünüm.
/// - `emailField`: E-posta adresi giriş alanını döndüren alt görünüm.
/// - `passwordField`: Şifre giriş alanını döndüren alt görünüm.
struct RegisterView: View {
    /// Kayıt işlemlerini yöneten ViewModel.
    @StateObject var viewModel = RegisterViewViewModel()
    
    /// Odaklanılan form alanını belirten `FocusState`.
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack {
            /// Başlık ve alt başlığı içeren üst kısım.
            HeaderView(title: String(localized: "Register"),
                       subTitle: String(localized: "Start Organizing todos"),
                       angle: -15,
                       background: .orange)
                .offset(y: -40)
            
            Form {
                /// Hata mesajını gösteren metin.
                errorMessageView
                /// Kullanıcı adı giriş alanı.
                usernameField
                /// E-posta adresi giriş alanı.
                emailField
                /// Şifre giriş alanı.
                passwordField
                
                /// Kayıt butonu.
                TLButton(text: String(localized:"Register"),
                         backgroundColor: .blue,
                         state: .enabled,
                         textWidth: .infinity,
                         isRequesting:viewModel.buttonState) {
                    viewModel.register()
                }
                         .padding()
            }
            .offset(y: -50)
            
            Spacer()
        }
        .fullScreenCover(isPresented: $viewModel.isAuthenticated) {
            MainView()
        }
        .ignoresSafeArea(.keyboard)
    }
    
    /// Hata mesajını gösteren alt görünüm.
    @ViewBuilder
    private var errorMessageView: some View {
        if !viewModel.errorMessage.isEmpty {
            Text(viewModel.errorMessage)
                .foregroundColor(.red)
        }
    }
    
    /// Kullanıcı adı giriş alanını döndüren alt görünüm.
    private var usernameField: some View {
        TextField("Username", text: $viewModel.name)
            .textFieldStyle(.automatic)
            .autocorrectionDisabled()
            .submitLabel(.next)
            .focused($focusedField, equals: .username)
            .onSubmit {
                focusedField = .email
            }
    }
    
    /// E-posta adresi giriş alanını döndüren alt görünüm.
    private var emailField: some View {
        TextField("Email Address", text: $viewModel.email)
            .textFieldStyle(.automatic)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .autocorrectionDisabled()
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
                viewModel.register()
            }
    }
}

#Preview {
    RegisterView()
}
