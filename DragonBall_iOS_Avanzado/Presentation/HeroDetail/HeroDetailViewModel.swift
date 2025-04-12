//
//  HeroDetailViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 11/4/25.
//


enum HeroDetailState: Equatable {
    case error(reason: String)
    case loading
    case succcess
}

final class HeroDetailViewModel {
    let onStateChanged = Binding<HeroDetailState>()
    private let useCaseLocation: GetHeroLocationsProtocol
    private let useCaseTransformation: GetHeroTransformationProtocol // TODO: Refactorizar para que sea un array y no dos variables separadas
    private var locations: [HeroLocation] = []
    private(set) var transformation: [HeroTransformation]?
    private(set) var hero: Hero?
    
    init(hero: Hero?, useCaseLocation: GetHeroLocationsProtocol, useCaseTransformation: GetHeroTransformationProtocol){
        self.hero = hero
        self.useCaseLocation = useCaseLocation
        self.useCaseTransformation = useCaseTransformation
        
    }
    
    func loadDataHero(){
        onStateChanged.update(.loading)
        
        guard let hero = hero else {
            onStateChanged.update(.error(reason: "No se encontró el héroe"))
            return
        }
        
        useCaseLocation.fetchLocationForHeroWhith(id: hero.id) { [weak self] result in
            switch result {
            case .success(let locations):
                self?.locations = locations
                self?.onStateChanged.update(.succcess)
                
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: String(describing: error)))
            }
        }
    }
    func loadDataTransformation(){
        onStateChanged.update(.loading)
        guard let hero = hero else {
            onStateChanged.update(.error(reason: "No se encontró el héroe"))
            return
        }
        
        useCaseTransformation.fetchTransformationForHeroWhith(id: hero.id) {[weak self] result in
            switch result {
            case .success(let transformations):
                self?.transformation = transformations
                self?.onStateChanged.update(.succcess)
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: String(describing: error)))
            }
        }
        
        // TODO: Falta un getHeroLocations
        
    }
}
