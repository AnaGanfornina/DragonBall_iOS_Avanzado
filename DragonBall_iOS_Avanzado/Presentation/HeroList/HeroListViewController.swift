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

final class HeroListViewController: UIViewController {
    
    private var viewModel: HeroesListViewModel
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak private var errorLabel: UILabel!
    
    // MARK: - DataSource
    
    typealias DataSource = UICollectionViewDiffableDataSource<HeroesSeccions, Hero>
    typealias CellRegistration = UICollectionView.CellRegistration< HeroCell, Hero>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HeroesSeccions, Hero>
    
    // MARK: - Data
    
    private var dataSource: DataSource?
    private var heroes: [Hero] = []
    
    // MARK: - Initializer
    
    init(viewModel: HeroesListViewModel) {
        self.viewModel = viewModel
         
        super.init(nibName: "HeroListView", bundle: Bundle(for: type(of: self)))
         
        
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
    
    // MARK: - Actions
    
    @IBAction func logoutTapped(_ sender: Any) {
        // Le decimos al ViewModel que limpie la base de datos
        viewModel.performLogout()
        //navigationController?.popViewController(animated: true) // Nos lleva al primer viewControler que haya en el stacNavigation
        dismiss(animated: true)
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
        collectionView.delegate = self
        
        // configuramos los margenes de la rejilla
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 16
        }
        
        // Usamos un CellRegistration para crear las celdas  una ventaja que tiene es que si usamos el objeto como
        // identificador ya nos viene en el handler y no necesitamos acceder a él por su indexPath
        let nib = UINib(nibName: HeroCell.identifier, bundle: nil)
        let cellRegistration = CellRegistration(cellNib: nib) { cell, _, hero in
            
            cell.configure(with: hero)
        }
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, hero in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: hero)
            
        })
    }
    
    // MARK: - State rendering
    private func renderError(_ reason: String){
        errorLabel.isHidden = false
        errorLabel.text = reason
    }

    private func renderLoading(){}
    private func renderSuccess(){
        
        self.heroes = viewModel.heroes
        
        // Creacion del snapshot
        
        var snapshot = Snapshot()
        snapshot.appendSections([.heroes])
        snapshot.appendItems(heroes)
        dataSource?.applySnapshotUsingReloadData(snapshot)
    }
   
}
// MARK: - CollectionViewLayout

extension HeroListViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let columNumber: CGFloat = 2
        
        
        let width = (collectionView.frame.width - 32) / columNumber
        return CGSize(width: width, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let heroSelected = dataSource?.itemIdentifier(for: indexPath) else { return }
        
        // Nos vamos al detalle del heroe
        
        navigationController?.show(heroDetailBuilder(hero: heroSelected).build(), sender: self)
        
        
    }
}

