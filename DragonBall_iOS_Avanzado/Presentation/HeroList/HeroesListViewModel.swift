//
//  HeroesListViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 9/4/25.
//

import Foundation

enum HeroListState: Equatable{
    case error(reason: String)
    case loading
    case success
}

class HeroesListViewModel {
    
    let onStateChanged = Binding<HeroListState>()
    private let useCase: GetHeroesUseCaseProtocol
    private(set) var heroes: [Hero] = []
    private var storeData: StoreDataProvider
    private var secureData: SecureDataProtocol
    
    init(useCase: GetHeroesUseCaseProtocol = GetHeroesUseCase(),
         storeData: StoreDataProvider = .shared,
         secureData: SecureDataProtocol = SecureDataProvider()){
        self.useCase = useCase
        self.storeData = storeData
        self.secureData = secureData
        
    }
    
    /// Funcion encargada de recuperar los datos, ya sean del servicio o de la BBDD
    func loadData(){
        onStateChanged.update(.loading)
        useCase.run { [weak self] result in
            switch result {
            case .success(let heroes):
                self?.heroes = heroes
                self?.onStateChanged.update(.success)
            case .failure:
                self?.onStateChanged.update(.error(reason: "No tengo datos de héroes"))
            }
            
        }
    }
    
    ///Función para pasarle los heroes al snapshot del ViewController
    func fetchHeroes() -> [Hero] {
        heroes
    }
    
    /// Función para hacer logout y asi borrar el token y la BBDD
    func performLogout(){
        secureData.clearToken()
        storeData.clearBBDD()
    }
    
//    func heroWith(index: Int) -> Hero? {
//        guard index < heroes.count else { return nil }
//        
//        return heroes[index]
//    }
    
}
