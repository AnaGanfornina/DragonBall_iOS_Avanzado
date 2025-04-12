//
//  MockSecureDataProvider.swift
//  DragonBall_iOS_AvanzadoTests
//
//  Created by Ana on 13/4/25.
//

import Foundation

@testable import DragonBall_iOS_Avanzado
// Struct que implementa el protocol SecureDataProtocol
// Hace uso de Userdefaults para no modificar la información de la app guardada en el KeyChain
struct MockSecureDataProvider: SecureDataProtocol {
    let keyToken = "keytoken"
    let userDefaults = UserDefaults.standard
    
    func getToken() -> String? {
        userDefaults.value(forKey: keyToken) as? String
    }
    
    func setToken(_ token: String) {
        userDefaults.setValue(token, forKey: keyToken)
    }
    
    func clearToken() {
        userDefaults.removeObject(forKey: keyToken)
    }
}
