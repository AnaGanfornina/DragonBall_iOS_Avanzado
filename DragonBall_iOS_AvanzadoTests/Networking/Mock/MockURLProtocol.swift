//
//  MockURLProtocol.swift
//  DragonBall_iOS_AvanzadoTests
//
//  Created by Ana on 12/4/25.
//

import Foundation

// Mock de URLProtocol, nos va a permitir capturar las llamadas a los servicios web y testar todo nuestro código
// de la api, loúnico que no hacemos es la llmamada al backend que es lo que no queremos.

class MockURLProtocol: URLProtocol {
    
    // Para un caso de success reciviremos la request que podremos validar y haremos la función del backend
    // devolviendo el response y data que recive nuestro dataTask de ApiProvider.
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    // Daremos valor a error cuando queramos validar un caso de error
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // Si hay un error devuelve el error. En los casos donde queramos testear el error
        if let error = Self.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        
        // Si no le hemos pasado un error ni un closure es que no estamos implementando bien el protocolo por lo que lanzamos un fatal error
        guard let handler =  Self.requestHandler else {
            fatalError("An error or request handler must be provided")
        }
        
        do {
            // Implementamos los métodos para poder devolver el data y el response a urlSession
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
            
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    
    override func stopLoading() {}
    
    // Función estática que nos permite crear un httpResponse de forma fácil.
    static func httpResponse(url: URL, statusCode: Int = 200) -> HTTPURLResponse? {
        HTTPURLResponse(url: url,
                        statusCode: statusCode,
                        httpVersion: nil,
                        headerFields: ["Content-Type": "application/json, charset=utf-8"])
    }
}
