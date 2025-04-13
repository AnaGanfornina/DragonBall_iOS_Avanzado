//
//  LoginViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 7/4/25.
//

import UIKit

final class LoginViewController : UIViewController {
    
    private let viewModel:   LoginViewModel
    
    // MARK: - Outlets
    
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    // MARK: - Initializer
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - IBActions
    
    /// Para emitir enventos al ViewModel, cuando pulse el botón la vista invoca el proceso de login del ViewModel
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        viewModel.login(username: nameField.text, password: passwordField.text)
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
    }
    
    // MARK: - Binding
    
    private func bind() {
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .error(let reason):
                self?.renderError(reason)
            case .success:
                self?.renderSuccess()
            case .loading:
                self?.renderLoading()
            }
        
        }
    }
    
    // MARK: Stage management
    //Renderizado de cada uno de los estados dividido por funciones. Para luego llamarlas desde el bind()
    
    private func renderSuccess() {
        
        //Navegamos hacia el HeroList
        
        
        //navigationController?.setViewControllers([HeroesListBuilder().build()], animated: true)
        present(HeroesListBuilder().build(), animated: true)
        
    }
    private func renderLoading() {
        // TODO: poner aqui algo como un simbolo cargando o algo asi
        //nameField.isHidden = false
        //passwordField.isEnabled = false
        errorLabel.isHidden = true
        
       
    }
    
    private func renderError(_ message: String){
        errorLabel.text = message
        errorLabel.isHidden = false
        
    }
    
}
