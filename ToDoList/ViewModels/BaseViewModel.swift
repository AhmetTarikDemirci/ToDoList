//
//  BaseViewModel.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 26.07.2024.
//

import Foundation
import SwiftUI

/// `BaseViewModel`, temel görünüm modelini temsil eder ve `ObservableObject` protokolünü uygular.
///
/// Bu sınıf, genel durum yönetimini ve kullanıcı arayüzü ile etkileşimleri yönetir.
/// Diğer tüm ViewModel sınıfları, `BaseViewModel` sınıfını genişleterek bu temel işlevsellikleri miras alır.
///
/// `BaseViewModel`, verilerin yüklenme durumunu, görünümlerin yeniden yüklenebilirliğini,
/// alt sayfa (sheet) gösterim durumlarını ve kullanıcı arayüzündeki çeşitli mesaj ve görsel bilgilerini yönetir.
class BaseViewModel: ObservableObject {
    
    /// Yeniden yüklenebilirliği belirten bir bayrak.
    /// Kullanıcı arayüzünün tekrar yüklenip yüklenemeyeceğini kontrol eder.
    @Published var isRefreshable: Bool = false
    
    /// Butonun etkinlik durumu.
    @Published var buttonState: Bool = false
    
    /// İstek durumunu temsil eder.
    /// Verilerin yüklenme durumunu takip eder ve kullanıcıya geri bildirim sağlar.
    @Published var requestState: RequestState = .loading
    
    /// Alt sayfayı (sheet) göstermek için kullanılan bayrak.
    /// Bir alt sayfa (sheet) göstermek için kullanılır.
    @Published var showSheet = false
    
    @Published var toast: Toast?
    
    /// Alt sayfanın (sheet) açık olup olmadığını belirten bayrak.
    /// Alt sayfanın (sheet) gösterilip gösterilmediğini takip eder.
    @Published var isSheetPresented = false
    
    /// Görüntü URL'sini veya adını içeren opsiyonel değişken.
    /// Kullanılacak görselin URL'sini veya adını saklar.
    var image: String?
    
    /// Başlık metnini içeren opsiyonel değişken.
    /// Kullanıcı arayüzünde gösterilecek başlık metnini saklar.
    var title: String?
    
    /// İlk mesaj metnini içeren opsiyonel değişken.
    /// Kullanıcı arayüzünde gösterilecek ilk mesaj metnini saklar.
    var message1: String?
    
    /// İkinci mesaj metnini içeren opsiyonel değişken.
    /// Kullanıcı arayüzünde gösterilecek ikinci mesaj metnini saklar.
    var message2: String?
    
    /// Buton üzerindeki metni içeren opsiyonel değişken.
    /// Buton üzerinde gösterilecek metni saklar.
    var buttonText: String?
    
    /// Butonun rengini belirten opsiyonel değişken.
    /// Butonun rengini tanımlar.
    var buttonColor: Color?
    
    /// Butonun görünür olup olmadığını belirten bayrak.
    /// Butonun kullanıcıya görünüp görünmediğini belirler.
    var buttonVisible: Bool = false
    
    /// Butona tıklandığında çalışacak aksiyonu temsil eder.
    /// Butona tıklandığında yürütülecek olan işlemi tanımlar.
    var action: (() -> Void)?
    
    /// Tekrar deneme fonksiyonu.
    ///
    /// Bu metod, genellikle ağ istekleri başarısız olduğunda tekrar denemek için kullanılır.
    func retry() {
        // Retry logic implementation goes here.
    }
    
    func showSuccessToast(message: String) {
        toast = Toast(style: .success, message: message)
    }

    func showErrorToast(message: String) {
        toast = Toast(style: .error, message: message)
    }
    
    func clearToast() {
           toast = nil
       }
}
