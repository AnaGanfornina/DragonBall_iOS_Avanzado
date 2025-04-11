//
//  GetHeroesUseCase.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 9/4/25.
//

struct GetHeroesError: Error {
    let reason: String
}


protocol GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[Hero], GetHeroesError>) -> Void)
}

final class GetHeroesUseCase: GetHeroesUseCaseProtocol {
    
    //Hace uso del ApiProvider para obtener los datos
    private var apiProvider: ApiProvider
    //y de core data para poder obtener los datos de la BBDD
    private var storeData: StoreDataProvider
    
    
    init(apiProvider: ApiProvider = ApiProvider(), storeData: StoreDataProvider = .shared) {
        self.apiProvider = apiProvider
        self.storeData = storeData
        
    }
    
    func run(completion: @escaping (Result<[Hero], GetHeroesError>) -> Void) {
        
        // Ejecutamos aquí la llamada a la api (que en un futuro no será aqui)
        // Comporbamos si tenemos los datos en BBD sis es así los usamos, si no se piden al servicio web

        let localHeroes = loadHeroes()
        
        if localHeroes.isEmpty {
            apiProvider.getHeroes { [weak self] result in
                switch result {
                case .success(let apiHeroes):
                    // Insertamos la info en la base de datos
                    self?.storeData.context.performAndWait { // Usamos performAndWite para evitar Race conditions
                        self?.storeData.insert(heroes: apiHeroes)
                        completion(.success(self?.loadHeroes() ?? []))
                    }
                case .failure:
                    completion(.failure(GetHeroesError(reason: "Ha ocurrido un error al llamar a la api")))
                }
            }
        } else {
            completion(.success(localHeroes))
        }
        
        
    }
    

    
    /// Función que carga los heroes desde la BBDD
    private func loadHeroes() -> [Hero] {
        let heroes = storeData.fetchHeroes(filter: nil)
        return heroes.map { $0.mapToHero() }
        
    }
    
    
}
