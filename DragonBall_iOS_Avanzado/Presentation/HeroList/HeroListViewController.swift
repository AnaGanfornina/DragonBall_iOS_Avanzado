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
    
    // MARK: - DataSource
    
    typealias DataSource = UICollectionViewDiffableDataSource<HeroesSeccions, Hero>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HeroesSeccions, Hero>
    
    // MARK: - Data
    
    private var dataSource: DataSource?
    private let heroes: [Hero]
    
    // MARK: - Initializer
    
    init(viewModel: HeroesListViewModel) {
        self.viewModel = viewModel
        self.heroes = viewModel.getHeroes()
        
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
        
        // Creacion del snapshot
        
        var snapshot = Snapshot()
        snapshot.appendSections([.heroes])
        snapshot.appendItems(heroes)
        
        // y añadirlos a la fuente de datos
        
        dataSource?.apply(snapshot)
    }
    
    
    // MARK: - CollectionViewLayout
    
}
