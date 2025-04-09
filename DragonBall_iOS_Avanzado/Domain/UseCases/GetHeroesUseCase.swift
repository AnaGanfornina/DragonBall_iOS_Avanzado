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
    pr
    
    init(apiProvider: ApiProvider = ApiProvider()) {
        self.apiProvider = apiProvider
        
    }
    
    func run(completion: @escaping (Result<[Hero], GetHeroesError>) -> Void) {
        
        // Ejecutamos aquí la llamada a la api (que en un futuro no será aqui)
        // Comporbamos si tenemos los datos en BBD sis es así los usamos, si no se piden al servicio web

        
        apiProvider.getHeroes { response in
            switch response {
                
            case .success(_):
                <#code#>
            case .failure(_):
                completion(.failure(GetHeroesError(reason: "No se han cargado los heroes desde la api")))
            }
        }
        
        
    }
    
    /// Función que carga los heroes desde la BBDD
    private func loadHeroes() -> [Hero] {
        
        
    }
    
    
}
