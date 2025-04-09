//
//  LoginUseCase.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 8/4/25.
//

import Foundation

struct LoginError: Error {
    let reason: String
}

protocol LoginUseCaseProtocol {
    //Para poder invertir la dependencia con el caso de uso que tiene que tener el LoginViewModel
    func run(username: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void)

}
/// Es quien aplica la lógica de negocio, en este caso el login
final class LoginUseCase: LoginUseCaseProtocol {
    
    //Hace uso del ApiProvider para obtener los datos
    private var apiProvider: ApiProvider
    private var secureData: SecureDataProtocol
    
    init(apiProvider: ApiProvider = ApiProvider(), secureData: SecureDataProtocol = SecureDataProvider()) {
        self.apiProvider = apiProvider
        self.secureData = secureData
    }
    
    func run(username: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        
        // Comprobamos que son contraseñas y usuarios validos
        guard isValidUsername(username) else {
            return completion(.failure(LoginError(reason: "El usuario no es válido")))
        }
        guard isValidPassword(password) else {
            return completion(.failure(LoginError(reason: "La contraseña no es válida")))
        }
        
        // Ejecutamos aquí la llamada a la api (que en un futuro no será aqui)
        apiProvider.login(username: username, password: password) {[weak self] response in
            switch response {
            case .success(let data):
                // guardamos el token
                let token = String(describing: data)
                print(token)
                    
                self?.secureData.setToken(token)
                
            case .failure:
                completion(.failure(LoginError(reason: "Ha ocurrido un error en la red")))
            }
        }
    }
    
    // MARK: - Funciones de validación
    
    private func isValidUsername(_ string: String) -> Bool {
        !string.isEmpty && string.contains("@")
    }
    
    private func isValidPassword(_ string: String) -> Bool {
        string.count >= 4
    }
    
}
