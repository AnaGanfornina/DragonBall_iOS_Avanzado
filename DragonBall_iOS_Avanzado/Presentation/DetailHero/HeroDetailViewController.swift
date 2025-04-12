//
//  HeroDetailViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 11/4/25.
//


import UIKit
import MapKit


final class HeroDetailViewController: UIViewController {
    
    private let viewModel: HeroDetailViewModel
    
    // MARK: - Outlets
    @IBOutlet weak var heroLocation: MKMapView!
    
    @IBOutlet weak var heroDescriptionTextView: UITextView!
    // MARK: - Initializer
    
    init(viewModel: HeroDetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: "HeroDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        bind()
        viewModel.loadData()
        
    }
    
    // MARK: - Binding
    
    private func bind() {
        viewModel.onStateChanged.bind {[weak self] state in
            switch state {
                
            case .error(let reason):
                self?.renderError(reason)
            case .loading:
                self?.renderLoading()
            case .succcess:
                self?.renderSucces()
            }
        }
    }
    
    // MARK: - Stage management
    
    private func renderError(_ reason: String){}
    private func renderLoading(){}
    private func renderSucces() {
        guard let hero = viewModel.hero else {return}
    
        
        heroDescriptionTextView.text = hero.description
        title = hero.name
        
         
    }
    
}
