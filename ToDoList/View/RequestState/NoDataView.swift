//
//  NoDataView.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 26.07.2024.
//

import SwiftUI

/// `NoDataView`, veri bulunamadığında kullanıcıya gösterilen görünümü temsil eder.
///
/// Bu görünüm, veri eksikliği durumunda kullanıcıya bilgilendirici mesajlar ve bir aksiyon butonu göstermek için kullanılır.
struct NoDataView: View {
    /// Görünüm modelini temsil eden `BaseViewModel` nesnesi.
    var viewModel: BaseViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                Spacer()
                
                /// Görünüm modelinde tanımlı olan görüntüyü gösterir.
                if let image = viewModel.image {
                    Image(systemName: image)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .foregroundColor(.colorBlack.opacity(0.8))
                }
                
                VStack(spacing: 16) {
                    /// Görünüm modelinde tanımlı olan başlığı gösterir.
                    if let title = viewModel.title {
                        Text(title)
                            .title3Semibold()
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack(spacing: 12) {
                        /// Görünüm modelinde tanımlı olan ilk mesajı gösterir.
                        if let message1 = viewModel.message1 {
                            Text(message1)
                                .calloutRegular()
                                .foregroundColor(.colorGrey)
                                .multilineTextAlignment(.center)
                        }
                        
                        /// Görünüm modelinde tanımlı olan ikinci mesajı gösterir.
                        if let message2 = viewModel.message2 {
                            Text(message2)
                                .calloutRegular()
                                .foregroundColor(.colorGrey)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                
                /// Eğer buton görünürse, butonu ve tıklanma aksiyonunu gösterir.
                if viewModel.buttonVisible {
                    if let buttonText = viewModel.buttonText, let buttonColor = viewModel.buttonColor {
                        TLButton(text: buttonText, backgroundColor: buttonColor, state: .enabled) {
                            viewModel.action?()
                        }
                    }
                }
                
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }
}
