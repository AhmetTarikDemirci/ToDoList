//
//  LoggableService.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 24.07.2024.
//

import Foundation
import Alamofire

/// `LoggableService` protokolü, loglama işlevini tanımlar.
///
/// Bu protokol, loglama işlemi için bir `debugLog` fonksiyonu içerir.
protocol LoggableService {
    func debugLog()
}

extension DataRequest: LoggableService {
    /// `DataRequest` sınıfına loglama işlevi ekler.
    ///
    /// ### Açıklamalar
    /// - `debugLog()`: İsteğin cURL açıklamasını loglar.
    @objc
    func debugLog() {
        #if DEBUG
        print("===================================== \n")
        print(self.cURLDescription() + "\n")
        print("===================================== \n")
        #endif
    }
}

extension DataResponse: LoggableService {
    /// `DataResponse` sınıfına loglama işlevi ekler.
    ///
    /// ### Açıklamalar
    /// - `debugLog()`: Yanıtın serileştirme süresini ve metriklerini loglar.
    func debugLog() {
        #if DEBUG
        print("Serialization Duration: \(self.serializationDuration)")
        if let metrics = self.metrics {
            print("Duration: \(metrics.taskInterval.duration)")
        }
        #endif
    }
}
