//
//  ErrorConversions.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation

/// `Error` uzantısı, hata türlerini `ApiError` türüne dönüştürmek için yardımcı bir fonksiyon sağlar.
extension Error {
    /// Hata türünü `ApiError` olarak döner.
    ///
    /// Eğer hata zaten `ApiError` türünde ise direkt olarak döner. Aksi takdirde, `requestFailed` hatasını döner.
    ///
    var asApiError: ApiError {
        return (self as? ApiError) ?? .requestFailed
    }
}
