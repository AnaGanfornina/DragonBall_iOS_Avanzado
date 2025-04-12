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
    private let useCase: HeroDetailUseCaseProtocol
    private var locations: [HeroLocation] = []
    private(set) var hero: Hero?
    
    init(useCase: HeroDetailUseCaseProtocol, hero: Hero?){
        self.hero = hero
        self.useCase = useCase
        
    }
    
    func loadData(){
        onStateChanged.update(.loading)
        
        guard let hero = hero else {
            onStateChanged.update(.error(reason: "No se encontró el héroe"))
            return
        }
        
        useCase.fetchLocationForHeroWhith(id: hero.id) { [weak self] result in
            switch result {
            case .success(let locations):
                self?.locations = locations
                self?.onStateChanged.update(.succcess)
                
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: String(describing: error)))
            }
        }
    }
    
    // TODO: Falta un getHeroLocations
    
    
}
