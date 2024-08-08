//
//  EditProfileView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import SwiftUI

/// `EditProfileView` yapısı, kullanıcının profil bilgilerini düzenleyebileceği bir form sunar.
///
/// Bu görünüm, kullanıcı adı, e-posta ve şifre gibi bilgilerin düzenlenmesine olanak tanır.
struct EditProfileView: View {
    var body: some View {
        Form {
            Section {
                ForEach(EditType.allCases, id: \.self) { editType in
                    ProfileOption(title: editType.localizedTitle, editType: editType)
                }
            }
        }
        .navigationTitle(String(localized: "Edit Profile"))
    }
}

/// `ProfileOption` yapısı, belirli bir düzenleme türü için bir navigasyon bağlantısı sunar.
///
/// Bu görünüm, kullanıcının belirli bir profil bilgisini düzenleyebilmesi için bir seçenek sunar.
struct ProfileOption: View {
    /// Gösterilecek başlık metni.
    let title: String
    
    /// Düzenleme türü.
    let editType: EditType
    
    var body: some View {
        NavigationLink(destination: EditView(editType: editType)) {
            Text(title)
        }
    }
}

#Preview {
    EditProfileView()
}
