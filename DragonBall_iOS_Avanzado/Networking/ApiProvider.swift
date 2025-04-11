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
    
    func login(username: String, password: String, completion: @escaping (Result<String,NetworingError>) -> Void) {
        
        do {
            let request = try requestBuilder.build(endpoint: .login(username: username, password: password))
            // Aquí estamos enviando el token
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
                
                guard let token = String(data: data, encoding: .utf8) else {
                    completion(.failure(.decodingFailed))
                    return
                }
                completion(.success(token))
            }.resume()
            
        } catch {
            completion(.failure(error))
        }
    }


        // MARK: - Funcion para devolver los heroes
        
        func getHeroes(name: String = "", completion: @escaping (Result<[HeroDTO], NetworingError>) -> Void) {
            
            do {
                let request = try requestBuilder.build(endpoint: .heroes(name: name))
                manageResponse(request: request, completion: completion)
                
            } catch {
                completion(.failure(error))
            }
        }
        
        
        // MARK: - Funcion para devolver las localizaciones
        
        
        // MARK: - Función para manegar las respuesstas de la api
        
        /// Función que nos permite gestionar la respuesta de los servicios
        func manageResponse<T: Codable>(request: URLRequest, completion: @escaping (Result<T,NetworingError>) -> Void){
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
                
                
                do {
                    
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                        completion(.failure(.errorParsingData))
                }
            }.resume()
        }     
    }

    

