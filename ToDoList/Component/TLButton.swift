//
//  TLButton.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import SwiftUI

/// `ButtonState` enum'u, butonun etkinlik durumunu tanımlar.
///
/// - enabled: Buton etkin durumda.
/// - disabled: Buton etkin değil (devre dışı) durumda.
enum ButtonState {
    case enabled
    case disabled
}

/// `TLButton` yapısı, özelleştirilebilir bir buton bileşeni sunar.
///
/// Bu yapı, buton metni, arka plan rengi, buton durumu ve diğer özellikler ile birlikte bir buton oluşturur.
///
/// ### Kullanım Örneği
/// ```
/// struct ContentView: View {
///     var body: some View {
///         TLButton(
///             text: "Giriş Yap",
///             backgroundColor: Color.blue,
///             state: .enabled,
///             isRequesting: false
///         ) {
///             print("Butona tıklandı")
///         }
///     }
/// }
/// ```
///
/// - Parameters:
///   - text: Buton metni.
///   - textColor: Buton metninin rengi. Varsayılan değer `.colorAlwaysWhite`.
///   - backgroundColor: Butonun arka plan rengi.
///   - state: Butonun durumu (etkin veya etkin değil).
///   - textWidth: Buton metninin genişliği. Varsayılan değer `nil`.
///   - isRequesting: İstek gönderilip gönderilmediğini belirten durum. Varsayılan değer `false`.
///   - borderColor: Butonun kenar çizgisi rengi. Varsayılan değer `.lighterGrey`.
///   - action: Buton tıklandığında çalışacak eylem.
struct TLButton: View {
    /// Buton metni.
    var text: String
    
    /// Buton metninin rengi (varsayılan: `.colorAlwaysWhite`).
    var textColor: Color? = .colorAlwaysWhite
    
    /// Butonun arka plan rengi.
    var backgroundColor: Color
    
    /// Butonun durumu (etkin veya etkin değil).
    var state: ButtonState
    
    /// Buton metninin genişliği (varsayılan: `nil`).
    var textWidth: CGFloat? = nil
    
    /// İstek gönderilip gönderilmediğini belirten durum (varsayılan: `false`).
    var isRequesting: Bool = false
    
    /// Butonun kenar çizgisi rengi (varsayılan: `.lighterGrey`).
    var borderColor: Color? = .lighterGrey
    
    /// Buton tıklandığında çalışacak eylem.
    var action: () -> Void
    
    /// Butonun etkin olup olmadığını belirten durum.
    private var isDisabled: Bool {
        state == .disabled
    }
    
    /// Buton metni için etkili renk.
    private var effectiveTextColor: Color {
        textColor ?? .colorAlwaysWhite
    }
    
    /// Buton arka planı için etkili renk.
    private var effectiveBackgroundColor: Color {
        isDisabled ? backgroundColor.opacity(0.5) : backgroundColor
    }
    
    /// Buton kenar çizgisi için etkili renk.
    private var effectiveBorderColor: Color {
        borderColor ?? .lighterGrey
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if isRequesting {
                    ProgressView()
                } else {
                    Text(text)
                        .font(.body.weight(.semibold))
                        .foregroundColor(effectiveTextColor)
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 36)
            .frame(maxWidth: textWidth)
            .background(effectiveBackgroundColor)
            .foregroundColor(effectiveBackgroundColor)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(effectiveBorderColor, lineWidth: 1)
            )
        }
        .disabled(isDisabled || isRequesting)
    }
}

#Preview {
    TLButton(
        text: "Giriş Yap",
        backgroundColor: Color.colorMain,
        state: .enabled,
        isRequesting: false
    ) { }
}
