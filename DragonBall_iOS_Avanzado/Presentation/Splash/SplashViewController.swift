//
//  SplashController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 6/4/25.
//

import UIKit

final class SplashViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: dependiendo de si tenemos token de session navegamos a login o la pantallas de Heroes
        super.viewWillAppear(animated)
        bind()
        viewModel.load()
        
    }
    
    // MARK: - Binding
    
    /// Nos vamos a "suscribir" a los cambios del ViewModel
    private func bind(){
        
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .loading:
                // TODO: - No quieres hacer algo aqui ?
                print("Cargando")
            case .error:
                // TODO: - No quieres hacer algo aqui ?
                print("Ha ocurrido un error en el splash")
            case .readyToLogin:
                //self?.navigationController?.show(LoginBuilder().build(), sender: self)
                self?.navigationController?.setViewControllers([LoginBuilder().build()], animated: true)
                
            case .readyToList:
                self?.present(HeroesListBuilder().build(), animated: true)
                
            }
        }
        
    }
    
}
