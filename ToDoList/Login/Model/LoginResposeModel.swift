//
//  LoginResponseModel.swift
//  ToDoList
//
//  Created by Ahmet Tarık Demirci on 3.08.2024.
//

import Foundation

/// `LoginResponse` yapısı, bir giriş isteğine yanıt olarak sunucudan dönen verileri temsil eder.
///
/// Bu yapı, giriş işleminin sonucunu, sunucu tarafından dönen mesajı, bir token (eğer mevcutsa) ve kullanıcı bilgilerini içerir.
///
/// ### Özellikler
/// - `success`: Giriş işleminin başarı durumunu belirten tamsayı. 1 ise başarılı, 0 ise başarısız anlamına gelir.
/// - `message`: Sunucudan dönen mesaj. Giriş işleminin başarılı olup olmadığını veya neden başarısız olduğunu belirten metin.
/// - `token`: Giriş işlemi başarılı olduğunda dönen token. Bu token, kullanıcıyı doğrulamak için kullanılabilir. Opsiyonel bir değer olup, giriş başarısız olduğunda nil olabilir.
/// - `user`: Kullanıcı bilgilerini içeren model. Giriş işlemi başarılı olduğunda kullanıcının bilgilerini içerir. Opsiyonel bir değer olup, giriş başarısız olduğunda nil olabilir.
struct LoginResponse: Decodable {
    /// Giriş işleminin başarı durumunu belirten tamsayı.
    let success: Int
    
    /// Sunucudan dönen mesaj.
    let message: String
    
    /// Giriş işlemi başarılı olduğunda dönen token. Opsiyonel.
    let token: String?
    
    /// Kullanıcı bilgilerini içeren model. Opsiyonel.
    let user: User?
}
