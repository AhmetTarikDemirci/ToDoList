//
//  TextExtensions.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 26.07.2024.
//

import Foundation
import SwiftUI

/// `Text` uzantısı, SwiftUI `Text` görsel bileşeni için çeşitli stil yöntemleri sağlar.
///
/// Bu uzantı, `Text` bileşeninin farklı başlık, gövde ve diğer metin stilleri ile kullanılmasına olanak tanır.
extension Text {
    
    /// `Text` bileşenine `title` boyutunda ve `bold` ağırlığında stil uygular.
    ///
    /// - Returns: Stil uygulanmış `Text` bileşeni.
    func titleSemibold() -> some View {
        self
            .font(.title)
            .fontWeight(.bold)
    }
    
    /// `Text` bileşenine `title2` boyutunda ve `regular` ağırlığında stil uygular.
    ///
    /// - Returns: Stil uygulanmış `Text` bileşeni.
    func title2Regular() -> some View {
        self
            .font(.title2)
            .fontWeight(.regular)
    }
    
    /// `Text` bileşenine `title3` boyutunda ve `semibold` ağırlığında stil uygular.
    ///
    /// - Returns: Stil uygulanmış `Text` bileşeni.
    func title3Semibold() -> some View {
        self
            .font(.title3)
            .fontWeight(.semibold)
    }

    /// `Text` bileşenine `callout` boyutunda ve `regular` ağırlığında stil uygular.
    ///
    /// - Returns: Stil uygulanmış `Text` bileşeni.
    func calloutRegular() -> some View {
        self
            .font(.callout)
            .fontWeight(.regular)
    }

}
