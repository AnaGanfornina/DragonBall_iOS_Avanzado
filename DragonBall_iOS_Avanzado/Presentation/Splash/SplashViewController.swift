//
//  SplashController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 6/4/25.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let viewModel: SplashViewModel
    
    // MARK: - Initializer

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "SplashView", bundle: Bundle(for: type(of: self)))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        // dependiendo de si tenemos token de session navegamos a login o la pantallas de Heroes
        super.viewWillAppear(animated)
    }
    
}
