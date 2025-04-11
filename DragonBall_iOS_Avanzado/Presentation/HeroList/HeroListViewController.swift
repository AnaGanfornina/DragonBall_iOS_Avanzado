//
//  HeroListViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 9/4/25.
//


import UIKit

enum HeroesSeccions {
    case heroes
}

final class HeroListViewController: UICollectionViewController {
    
    private var viewModel: HeroesListViewModel
    
    // MARK: - Outlets
    
    @IBOutlet weak private var errorLabel: UILabel!
    
    // MARK: - DataSource
    
    typealias DataSource = UICollectionViewDiffableDataSource<HeroesSeccions, Hero>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HeroesSeccions, Hero>
    
    // MARK: - Data
    
    private var dataSource: DataSource?
    private var heroes: [Hero] = []
    
    // MARK: - Initializer
    
    init(viewModel: HeroesListViewModel) {
        self.viewModel = viewModel
         
        
        // Configuramos la forma de la rejilla
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.loadData()
        configureCollectionView()
        
        
        
       
        
    }
    
    // MARK: - Binding
    
    private func bind(){
        viewModel.onStateChanged.bind {[weak self] state in
            switch state {
            case .error(let reason):
                self?.renderError(reason)
            case .loading:
                self?.renderLoading()
            case .success:
                self?.renderSuccess()
            }
        }
    }
    
    // MARK: - Configuración del CollectionView
    
    private func configureCollectionView(){
        // Registrar la celda
        let registration = UICollectionView.CellRegistration<HeroCell, Hero>(cellNib: UINib(nibName: "HeroCell", bundle: nil)) { cell, _, hero in
            cell.configure(with: hero)
        }
        
        // Crear la fuente de datos que vamos a representar en la tabla
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, hero in
            collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: hero)
        })
        
        // Asignamos la fuente de datos al collectionView
        
        collectionView.dataSource = dataSource
    }
    
    // MARK: - State rendering
    private func renderError(_ reason: String){
        errorLabel.isHidden = false
        errorLabel.text = reason
    }

    private func renderLoading(){}
    private func renderSuccess(){
        
        self.heroes = viewModel.heroes
        print(heroes)
        // Creacion del snapshot
        
        var snapshot = Snapshot()
        snapshot.appendSections([.heroes])
        snapshot.appendItems(heroes)
        dataSource?.apply(snapshot)
    }
   
}
// MARK: - CollectionViewLayout

extension HeroListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let columNumber: CGFloat = 2
        let width = (collectionView.frame.size.width - 32) / columNumber
        return CGSize(width: width, height: 125)
    }
}
