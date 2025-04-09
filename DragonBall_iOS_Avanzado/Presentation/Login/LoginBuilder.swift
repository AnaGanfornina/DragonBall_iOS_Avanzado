//
//  LoginBuilder.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 8/4/25.
//

import UIKit

final class LoginBuilder {
    func build() -> UIViewController {
        
        let useCase = LoginUseCase()
        let loginViewModel = LoginViewModel(useCase: useCase)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        
        return loginViewController
        
    }
}
