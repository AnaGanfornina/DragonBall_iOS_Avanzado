//
//  GetHeroTransformationUseCase.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 12/4/25.
//

import Foundation

protocol GetHeroTransformationProtocol {
    func fetchTransformationForHeroWhith(id: String, completion: @escaping (Result<[HeroTransformation], NetworingError>) -> Void)
}

final class GetHeroTransformationUseCase: GetHeroTransformationProtocol {
    
    private var storeData: StoreDataProvider
    private var apiProvider: ApiProvider
    
    init(storeData: StoreDataProvider = .shared, apiProvider: ApiProvider = .init()) {
        self.storeData = storeData
        self.apiProvider = apiProvider
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
    
    /// Funcion para mapear los objetos de la base de datos MOTransforamtion a un tipo HeroTransformation del modelo
    private func storedTransformationForHeroWith(id: String) -> [HeroTransformation] {
        let predicate = NSPredicate(format: "identifier == %@", id)
        
        guard let hero = storeData.fetchHeroes(filter: predicate).first,
              let transformations = hero.transformation else {return []}
        
        return transformations.map({$0.mapToTransformation()})
        
        
    }
    
    
}
