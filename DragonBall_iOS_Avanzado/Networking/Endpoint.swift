//
//  Endpoint.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 8/4/25.
//

import Foundation

enum Endpoint {
    case login(username: String, password: String)
    case heroes(name: String)
    case locations(id: String)
    
    
    // Variable para indiocar si el endpoint debe llevar cavecera de autenticación con el token
    
    var isAuthoritationRequired: Bool {
        switch self {
        case .heroes, .locations:
            return true
        case .login:
            return false
        }
    }
    
  
    
    
    func path() -> String {
        switch self {
        case .login:
            return "/api/auth/login"
        case .heroes:
            return "/api/heros/all"
        case .locations:
            return "/api/heros/locations"
        }
    }
    
    func httpMethod() -> String {
        switch self {
        case .login, .heroes, .locations:
            return HTTPMethods.POST.rawValue
        }
    }
    
    /// Estamos configurando lo que habría en el body de nuestra request
    func params() -> Data? {
        switch self {
            
        case .login(username: let username, password: let password):
            let atributes = ["username": username, "password": password]
            // Creamos data a partir de un diccionario
            let data = try? JSONSerialization.data(withJSONObject: atributes)
            return data
            
        case .heroes(name: let name):
            let atributes = ["name": name]
            let data = try? JSONSerialization.data(withJSONObject: atributes) // Esto es para poder codifigar un diccionario y poder pasarselo como data al la api
            return data
        case .locations(id: let id):
            let atributes = ["id": id ]
            let data = try? JSONSerialization.data(withJSONObject: atributes)
            return data
        }
    }
   
    
}
