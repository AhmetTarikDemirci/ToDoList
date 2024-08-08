//
//  ErrorView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 26.07.2024.
//

import SwiftUI

/// `ErrorView`, hata durumlarında kullanıcıya gösterilen görünümü temsil eder.
///
/// Bu görünüm, kullanıcıya bir hata mesajı göstermek ve tekrar deneme seçeneği sunmak için kullanılır.
struct ErrorView: View {
    /// Tekrar deneme eylemini gerçekleştirecek işlev.
    var retryAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            /// "Tekrar Deneyin" butonu. Bu butona tıklandığında `retryAction` işlevi çağrılır.
            Button(String(localized: "try_again"), action: retryAction)
            
            Spacer()
        }
    }
}

#Preview {
    ErrorView {
        // Tekrar deneme işlevi burada sağlanmalıdır.
    }
}
