//
//  DateFormatter.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation

/// `DateFormatter` uzantısı, ISO 8601 formatında tarih ve saat düzenlemek için yardımcı bir formatter sağlar.
///
/// Bu uzantı, `iso8601Full` adında statik bir `DateFormatter` özelliği içerir.
extension DateFormatter {
    /// ISO 8601 formatında tarih ve saat düzenleyen bir `DateFormatter`.
    ///
    /// - `calendar`: ISO 8601 takvimi kullanır.
    /// - `timeZone`: GMT saat dilimini kullanır.
    /// - `locale`: Mevcut bölgesel ayarları kullanır.
    /// - `dateFormat`: "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXXX" tarih formatını kullanır.
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXXX"
        return formatter
    }()
}
