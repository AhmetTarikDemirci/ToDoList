//
//  LoadingView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 26.07.2024.
//

import SwiftUI

/// `LoadingView`, yükleme işlemleri sırasında kullanıcıya gösterilen yükleme göstergesini temsil eder.
///
/// Bu görünüm, bir işlemin yüklenmekte olduğunu belirtmek için bir `ProgressView` içerir.
struct LoadingView: View {

    var body: some View {
        VStack {
            /// Yükleme göstergesi. Görünüm, ekranın genişliğini kaplayacak şekilde ayarlanmış ve dikeyde 24 birim boşluk bırakılmıştır.
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
        }
    }
}

#Preview {
    LoadingView()
}
