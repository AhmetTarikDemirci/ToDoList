//
//  ToastView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 5.08.2024.
//

import SwiftUI

/// Bir bildirim (toast) mesajını gösteren görünüm.
///
/// Bu görünüm, belirli bir stil, mesaj ve genişlik ile bir bildirim gösterir.
/// Kullanıcı bildirim üzerindeki iptal düğmesine tıklayarak bildirimi kapatabilir.
///
/// - Parameters:
///   - style: Bildirimin stilini belirten `ToastStyle` türünde bir değer.
///   - message: Bildirimde gösterilecek mesaj.
///   - width: Bildirimin genişliği. Varsayılan değer sınırsızdır (`.infinity`).
///   - onCancelTapped: Kullanıcı iptal düğmesine tıkladığında çağrılan eylem.
struct ToastView: View {
  
    /// Bildirimin stili.
    var style: ToastStyle
    
    /// Bildirimde gösterilecek mesaj.
    var message: String
    
    /// Bildirimin genişliği. Varsayılan değer sınırsızdır (`.infinity`).
    var width = CGFloat.infinity
    
    /// Kullanıcı iptal düğmesine tıkladığında çağrılan eylem.
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(style.themeColor)
            Text(message)
                .font(Font.caption)
                .foregroundColor(Color("toastForeground"))
            
            Spacer(minLength: 10)
            
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(style.themeColor)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(Color("toastBackground"))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(style.themeColor, lineWidth: 1)
                .opacity(0.6)
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    ToastView(style: .success, message: "Başarılı bir şekilde kaydedildi.") {
        
    }
}
