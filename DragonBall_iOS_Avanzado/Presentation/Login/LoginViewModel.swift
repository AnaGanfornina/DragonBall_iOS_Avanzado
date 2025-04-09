//
//  LoginViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 7/4/25.
//

import Foundation

enum loginState: Equatable {
    case success
    case loading
    case error(reason: String)
}

/// Es quien REPRESENTA la logica de negocio aplicada por el caso de uso
final class LoginViewModel {
    
    let useCase: LoginUseCaseProtocol
    let onStateChanged = Binding<loginState>()
    
    // MARK: - Inicializer
    
    init(useCase: LoginUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func login(username: String?, password: String?){
        
        onStateChanged.update(.loading)
        
        //llamamos al caso de uso que es quien aplica la lógica de negocio
        
        useCase.run(username: username ?? "", password: password ?? "") {[weak self] result in
            switch result {
            case .success:
                self?.onStateChanged.update(.success)
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: error.reason))
            }
            
        }
    }
}
