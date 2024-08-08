//
//  RequestState.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 26.07.2024.
//

import Foundation
import SwiftUI

/// `RequestState`, bir isteğin durumunu temsil eden bir enum'dır.
///
/// Bu enum, isteklerin çeşitli durumlarını belirtir: veri yok, yükleme, başarı ve hata.
enum RequestState: Equatable {
    case nodata
    case loading
    case success
    case error(Error)
    
    static func == (lhs: RequestState, rhs: RequestState) -> Bool {
        switch (lhs, rhs) {
        case (.nodata, .nodata), (.loading, .loading), (.success, .success):
            return true
        case let (.error(lhsError), .error(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

/// `RequestStateController`, istek durumuna göre farklı görünümler sağlayan bir kontrolördür.
///
/// Bu görünüm, istek durumuna göre farklı içerikler göstermek için kullanılır.
struct RequestStateController<Content: View>: View {
    
    /// Görünüm modelini temsil eden `BaseViewModel` nesnesi.
    var viewModel: BaseViewModel
    
    /// Başarılı durumda gösterilecek içerik.
    private let successContent: () -> Content
    
    /// Başarı durumunda `EmptyView` kullanılıp kullanılmayacağını belirten bayrak.
    private let usesEmptyViewForSuccess: Bool
    
    /// İstek durumunu temsil eden değişken.
    private var requestState = RequestState.loading
    
    /// Başarılı durumda dışarıdan bir görünüm alacak olan initializer.
    ///
    /// - Parameters:
    ///   - viewModel: `BaseViewModel` nesnesi.
    ///   - successContent: Başarılı durumda gösterilecek içerik.
    init(viewModel: BaseViewModel, @ViewBuilder successContent: @escaping () -> Content) {
        self.viewModel = viewModel
        self.successContent = successContent
        self.requestState = viewModel.requestState
        self.usesEmptyViewForSuccess = false
    }
    
    /// Başarılı durum için `EmptyView` kullanacak olan initializer.
    ///
    /// - Parameters:
    ///   - viewModel: `BaseViewModel` nesnesi.
    init(viewModel: BaseViewModel) where Content == EmptyView {
        self.viewModel = viewModel
        self.requestState = viewModel.requestState
        self.successContent = { EmptyView() }
        self.usesEmptyViewForSuccess = true
    }
    
    var body: some View {
        
        switch requestState {
        case .loading:
            LoadingView()
                .id(UUID())
        case .nodata:
            NoDataView(viewModel: viewModel)
        case .error(_):
            ErrorView {
                // TODO: Fix it
                viewModel.retry()
            }
        case .success:
            if usesEmptyViewForSuccess {
                EmptyView()
            } else {
                successContent()
            }
        }
    }
}
