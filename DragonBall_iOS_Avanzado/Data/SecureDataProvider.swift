//
//  SecureDataProvider.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 8/4/25.
//

import Foundation
import KeychainSwift

protocol SecureDataProtocol {
    func getToken() -> String?
    func setToken(_ token: String)
    func clearToken()
}

///Hace uso de KEychain para guardar la información del token en el llavero del dispositivo
class SecureDataProvider: SecureDataProtocol {
    
    private let keyToken = "keyToken"
    private let keyChain = KeychainSwift() // esta es la constante con la que vamos a acceder a los servicios de la librería
    
    func getToken() -> String? {
        keyChain.get(keyToken)
    }
    
    func setToken(_ token: String) {
        keyChain.set(token, forKey: keyToken)
    }
    
    func clearToken() {
        keyChain.delete(keyToken)
    }
}
