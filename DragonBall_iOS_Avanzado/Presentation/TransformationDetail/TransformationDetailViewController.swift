//
//  TransformationDetailViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 12/4/25.
//


import UIKit


final class TransformationDetailViewController: UIViewController {
    private let viewModel: TransformationDetailViewModel
    
    // MARK: - Outlets
    
    @IBOutlet weak private var tranformationImage: AsyncImage!
    @IBOutlet weak private var transformationNameLabel: UILabel!
    @IBOutlet weak private var transformationDescriptionTextView: UITextView!
    // MARK: - Initializer
    
    init(viewModel: TransformationDetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: "TransformationDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderSucces()
    }
    
   

    // MARK: - Binding
    
    /*
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
     */
    private func renderSucces(){
        guard let transformation = viewModel.transformation else { return }
        
        tranformationImage.setImage(transformation.photo ?? "")
        transformationNameLabel.text = transformation.name
        transformationDescriptionTextView.text = transformation.description
    }
    
}
