//
//  RequestBuilder.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 8/4/25.
//

import Foundation

struct RequestBuilder {
    /*
    var username: String
    var password: String
    
    init(username: String = "prueba", password: String = "") {
        self.username = username
        self.password = password
    }
    
    */
    /// Construye la url con el endpoint dado
    func buildURL(endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        components.path = endpoint.path()
        return components.url
    }
   
    
    func build(endpoint: Endpoint , username: String = "prueba", password: String = "", secureData: SecureDataProtocol = SecureDataProvider()) throws(NetworingError) -> URLRequest {
        
        guard let url = buildURL(endpoint: endpoint) else {
            throw .invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod()
        
        // Solo añadimos la cabecera del token a los servicios que les haga falta
        if endpoint.isAuthoritationRequired {
            guard let token = secureData.getToken() else {
                throw .sessionTokenMissed
            }
            
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if endpoint.isAuthorizationBasicRequired{
            print(username)
            
            let loginString = String(format: "%@:%@", username, password)
            
            guard let loginData = loginString.data(using: .utf8) else {
                throw.decodingFailed
            }
            let base64LoginData = loginData.base64EncodedString()
            request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
            
        } else {
            request.setValue("application/json, charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        
        request.httpBody = endpoint.params()
        
        return request
        
    }
}


