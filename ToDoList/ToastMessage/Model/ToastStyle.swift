//
//  ToastStyle.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 5.08.2024.
//

import Foundation
import SwiftUI

/// Bildirim (toast) mesajlarının stilini belirten enum.
///
/// Bu enum, bildirim mesajlarının hata veya başarı durumunu temsil eder.
enum ToastStyle {
  /// Hata durumunu temsil eden stil.
  case error
  
  /// Başarı durumunu temsil eden stil.
  case success
}

extension ToastStyle {
  /// Bildirim stiline göre temayı belirleyen renk.
  ///
  /// - Returns: `Color` türünde bir değer.
  var themeColor: Color {
    switch self {
    case .error: return Color.red
    case .success: return Color.green
    }
  }
  
  /// Bildirim stiline göre simge dosya adını belirleyen string.
  ///
  /// - Returns: `String` türünde bir değer.
  var iconFileName: String {
    switch self {
    case .success: return "checkmark.circle.fill"
    case .error: return "xmark.circle.fill"
    }
  }
}
