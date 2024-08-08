//
//  HeaderView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import SwiftUI

/// `HeaderView` yapısı, uygulamanın başlık ve alt başlığını gösteren özel bir başlık görünümüdür.
///
/// Bu görünüm, belirli bir açıyla döndürülmüş ve arka plan rengine sahip bir başlık ve alt başlık metni içerir.
///
/// ### Kullanım Örneği
/// ```
/// struct ContentView: View {
///     var body: some View {
///         HeaderView(
///             title: "To Do List",
///             subTitle: "Get things done",
///             angle: 15,
///             background: .pink
///         )
///     }
/// }
/// ```
///
/// - Parameters:
///   - title: Başlık metni.
///   - subTitle: Alt başlık metni.
///   - angle: Arka planın döndürülme açısı.
///   - background: Arka plan rengi.
struct HeaderView: View {
    /// Başlık metni.
    let title: String
    
    /// Alt başlık metni.
    let subTitle: String
    
    /// Arka planın döndürülme açısı.
    let angle: Double
    
    /// Arka plan rengi.
    let background: Color
    
    var body: some View {
        ZStack {
            /// Döndürülmüş arka plan rengine sahip yuvarlatılmış dikdörtgen.
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(background)
                .rotationEffect(Angle(degrees: angle))
        
            VStack {
                /// Başlık metni, kalın ve beyaz renkte.
                Text(title)
                    .titleSemibold()
                    .foregroundStyle(.white)
                
                /// Alt başlık metni, normal ve beyaz renkte.
                Text(subTitle)
                    .title2Regular()
                    .foregroundStyle(.white)
                    .padding(.top, 10)
            }
            .padding(.top, 30)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 300)
        .offset(y: -100)
    }
}

#Preview {
    HeaderView(title: "To Do List", subTitle: "Get things done", angle: 15, background: .pink)
}
