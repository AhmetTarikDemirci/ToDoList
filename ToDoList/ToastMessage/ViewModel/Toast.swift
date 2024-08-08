//
//  Toast.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 5.08.2024.
//

import Foundation

/// Bir bildirim (toast) mesajını temsil eden yapı.
///
/// Bu yapı, bir bildirimin stilini, mesajını, süresini ve genişliğini içerir.
/// Bildirimler kullanıcıya kısa mesajlar göstermek için kullanılır.
///
/// - Parameters:
///   - style: Bildirimin stilini belirten `ToastStyle` türünde bir değer.
///   - message: Bildirimde gösterilecek mesaj.
///   - duration: Bildirimin ekranda kalma süresi (saniye cinsinden). Varsayılan değer 3 saniyedir.
///   - width: Bildirimin genişliği. Varsayılan değer sınırsızdır (`.infinity`).
struct Toast: Equatable {
    
    /// Bildirimin stili.
    var style: ToastStyle
    
    /// Bildirimde gösterilecek mesaj.
    var message: String
    
    /// Bildirimin ekranda kalma süresi (saniye cinsinden). Varsayılan değer 3 saniyedir.
    var duration: Double = 3
    
    /// Bildirimin genişliği. Varsayılan değer sınırsızdır (`.infinity`).
    var width: Double = .infinity
}
