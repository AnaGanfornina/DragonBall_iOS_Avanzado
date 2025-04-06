//
//  SplashBuilder.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 6/4/25.
//

import UIKit

/// Función que construye objeto del SplashViewModel
final class SplashBuilder {
    
    func build() -> UIViewController {
        let viewModel = SplashViewModel()
        return SplashViewController(viewModel: viewModel)
    }
}
