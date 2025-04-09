//
//  ApiProvider.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 8/4/25.
//

import Foundation

// TODO: Implementar un protocolo

struct ApiProvider {
    var session: URLSession
    var requestBuilder: RequestBuilder
    
    init(session: URLSession = .shared, requestBuilder: RequestBuilder = .init()) {
        self.session = session
        self.requestBuilder = requestBuilder
    }
    
    // MARK: - Funcion para hacer login
    
    func login(username: String, password: String, completion: @escaping (Result<Data,NetworingError>) -> Void) {
        
        do {
            let request = try requestBuilder.build(endpoint: .login, username: username, password: password)
            
            session.dataTask(with: request) { data, response, error in
                
                if let error {
                    return completion(.failure(.serverError(error: error)))
                }
                
                //  Validamos el response, la respuesta de la petición el codigo
                
                let statusCode =  (response as? HTTPURLResponse)?.statusCode
                guard statusCode == 200 else {
                    completion(.failure(.responseError(code: statusCode)))
                    return
                }
                
                guard let data else {
                    completion(.failure(.noDataRecived))
                    return
                }
                
                // Aquí estamos enviando el token
        
                completion(.success(data))
            }.resume()
        } catch {
            completion(.failure(.invalidURL)) // TODO:  Este catch coge todos los fallos,no me gusta
        }
       /*
        guard let request = requestBuilder.build(endpoint: .login) else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            
            if let error {
                return completion(.failure(.serverError(error: error)))
            }
            
            //  Validamos el response, la respuesta de la petición el codigo
            
            let statusCode =  (response as? HTTPURLResponse)?.statusCode
            guard statusCode == 200 else {
                completion(.failure(.responseError(code: statusCode)))
                return
            }
            
            guard let data else {
                completion(.failure(.noDataRecived))
                return
            }
            
            // Aquí estamos enviando el token
    
            completion(.success(data))
        }.resume()
        */
        // MARK: - Funcion para devolver los heres
        
        // MARK: - Funcion para devolver las localizaciones
    }
    
}
