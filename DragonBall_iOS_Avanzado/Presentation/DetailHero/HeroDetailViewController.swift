//
//  HeroDetailViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 11/4/25.
//


import UIKit
import MapKit


enum HeroTransformationSection {
    case transformations
}

final class HeroDetailViewController: UIViewController {
    
    private let viewModel: HeroDetailViewModel
    
    // MARK: - Outlets
    @IBOutlet private weak var heroLocation: MKMapView!
    @IBOutlet private weak var heroDescriptionTextView: UITextView!
    @IBOutlet private weak var heroTransformationCollectionView: UICollectionView!
    
    // MARK: - DataSource
    
    typealias DataSource = UICollectionViewDiffableDataSource<HeroTransformationSection,HeroTransformation>
    typealias CellRegistration = UICollectionView.CellRegistration<TransformationCell, HeroTransformation>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HeroTransformationSection, HeroTransformation>
    
    // MARK: - Data
    
    private var dataSource: DataSource?
    private var transformations:[HeroTransformation] = []
    
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
        configureCollectionView()
        viewModel.loadDataHero()
        viewModel.loadDataTransformation()
        
        
    }
    // MARK: - Configuración del CollectionView
    func configureCollectionView(){
        heroTransformationCollectionView.delegate = self
        // configuramos los margenes de la rejilla?
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        heroTransformationCollectionView.collectionViewLayout = layout

        
        
        let nib = UINib(nibName: TransformationCell.identifier, bundle: nil)
        let cellRegistration = CellRegistration(cellNib: nib) { cell, _, transformation in
            cell.configure(whith: transformation)
        }
        dataSource = DataSource(collectionView: heroTransformationCollectionView, cellProvider: { collectionView, indexPath, transformation in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: transformation)
        })
        
        
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
        
        // Creacion del snapshot
        
        self.transformations = viewModel.transformation ?? []
        var snapshot = Snapshot()
        snapshot.appendSections([.transformations])
        snapshot.appendItems(transformations)
        dataSource?.applySnapshotUsingReloadData(snapshot)
    }
    
}


// MARK: - CollectionViewLayout
extension HeroDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: collectionView.bounds.size.width, height: 80.0)
        return CGSize(width: 200, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let transformationSelected = dataSource?.itemIdentifier(for: indexPath) else { return }
        
        // Nos vamos al detalle de Transformación
        print("nos vamos a transformación \(transformationSelected)")
        
       // navigationController?.show(, sender: self)
        
        
    }
}


