//
//  HeroDetailUseCase.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 11/4/25.
//
import Foundation

protocol HeroDetailUseCaseProtocol {
    func fetchLocationForHeroWhith(id: String, completion: @escaping( Result<[HeroLocation], NetworingError>) -> Void)
    func fetchTransformationForHeroWhith(id: String, completion: @escaping (Result<[HeroTransformation], NetworingError>) -> Void) 
}

final class HeroDetailUseCase: HeroDetailUseCaseProtocol {
    
    private var storeData: StoreDataProvider
    private var apiProvider: ApiProvider
    
    init(storeData: StoreDataProvider = .shared, apiProvider: ApiProvider = .init()) {
        self.storeData = storeData
        self.apiProvider = apiProvider
    }
    
    func fetchLocationForHeroWhith(id: String, completion: @escaping (Result<[HeroLocation], NetworingError>) -> Void) {
        
        let locationsHero = storedLocationsForHeroWith(id: id)
        
        // Comprobamos si hay localizaciones en la BBDD
        
        if locationsHero.isEmpty {
            apiProvider.getLocationsForHeroSith(id: id) {[weak self] result in
                switch result {
                case .success(let locations):
                    
                    self?.storeData.context.perform {
                        self?.storeData.insert(locations: locations)
                        let bdLocations = self?.storedLocationsForHeroWith(id: id) ?? []
                        completion(.success(bdLocations))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        } else {
            completion(.success(locationsHero))
        }
    }
    
    func fetchTransformationForHeroWhith(id: String, completion: @escaping (Result<[HeroTransformation], NetworingError>) -> Void) {
        let transformation = storedTransformationForHeroWith(id: id)
        
        // Comprobamos si hay transformaciones en la BBDD
        
        if transformation.isEmpty{
            apiProvider.getTransformation(id: id) { [weak self] result in
                switch result {
                case .success(let transformations):
                    self?.storeData.context.perform {
                        self?.storeData.isnert(transformations: transformations)
                        let bdTransformation = self?.storedTransformationForHeroWith(id: id) ?? []
                        completion(.success(bdTransformation))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.success(transformation))
        }
    }
    
    /// Funcion para mapear los objetos de la base de datos MOLocations a un tipo HeroLocation del modelo
    private func storedLocationsForHeroWith(id: String) -> [HeroLocation] {
        let predicate = NSPredicate(format: "identifier == %@", id)
        
        guard let hero = storeData.fetchHeroes(filter: predicate).first,
              let locations = hero.locations else {
            return []
        }
        return locations.map({$0.mapToHeroLocation()})
    }
    
    /// Funcion para mapear los objetos de la base de datos MOTransforamtion a un tipo HeroTransformation del modelo
    private func storedTransformationForHeroWith(id: String) -> [HeroTransformation] {
        let predicate = NSPredicate(format: "identifier == %@", id)
        
        guard let hero = storeData.fetchHeroes(filter: predicate).first,
              let transformations = hero.transformation else {return []}
        
        return transformations.map({$0.mapToTransformation()})
        
        
    }
}
