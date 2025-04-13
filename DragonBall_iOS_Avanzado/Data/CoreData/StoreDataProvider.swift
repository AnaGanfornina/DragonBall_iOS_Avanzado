//
//  StoreDataProvider.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 9/4/25.
//

import Foundation
import CoreData


enum TypePersistance {
    case disk
    case inMemory
}

final class StoreDataProvider {
    
    static let shared: StoreDataProvider = .init()
    
#if DEBUG
    
    static let sharedTesting: StoreDataProvider = .init(persistence: .inMemory)
    
#endif
    
    // Creación del stack, comenzando por el persistent container
    let persistentContainer: NSPersistentContainer // Es el que hace posible la creación de contextos
    
    lazy var context: NSManagedObjectContext = {
        let viewContext = self.persistentContainer.viewContext
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump // Politica ante duplicados
        return viewContext
    }()
    
    private init(persistence: TypePersistance = .disk) {
        self.persistentContainer = NSPersistentContainer(name: "Model")
        
        if persistence == .inMemory {
            let persistenceStore = self.persistentContainer.persistentStoreDescriptions.first
            persistenceStore?.url = URL(filePath: "dev/null")// Le decimos que el persistenceSotre de esta instancia de storeDataProvider tiene que crear la BBDD en memoria. Esto nos servirá para los test.
        }
        
        // Escribimos la BBDD
        self.persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Core data no ha podido cargar BBDD del Modelo \(error)")
            }
        }
    }
    func saveContext(){
        context.perform {
            guard self.context.hasChanges else { return }
            do{
                try self.context.save()
            } catch {
                debugPrint("Ha habido un error guardando el contexto\(error)")
            }
        }
    }

}

extension StoreDataProvider {
    
    ///Función para poder recuperar el heroe y pasarselo al insert de locations
    ///Aplica un filtro si se le envia
    func fetchHeroes(filter: NSPredicate?, sortAscending: Bool = true) -> [MOHero] {
        let request = MOHero.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \MOHero.name, ascending: sortAscending)
        
        request.sortDescriptors = [sortDescriptor]
        request.predicate = filter
        return (try? context.fetch(request)) ?? []
    }
    
    func fetchTransformation(filter: NSPredicate?, sortAscending: Bool = true) -> [MOTransformation] {
        let request = MOTransformation.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \MOTransformation.name, ascending: sortAscending)
        
        request.sortDescriptors = [sortDescriptor]
        request.predicate = filter
        return (try? context.fetch(request)) ?? []
    }
    
    // Función para saber el númeo de objetos de la bbdd sin que nos importe que son exactamente
    func numHeroes() -> Int {
        return (try? context.count(for: MOHero.fetchRequest())) ?? -1 // Ponemos -1 para combrobar que no está en su valor por defecto que es 0(no hay nada en la BBDD)
    }
    
    // Inserta heroes en contexto y persiste en BBDD con save Context()
    func insert(heroes: [HeroDTO]) {
        for hero in heroes {
            // Estamos crando el objeto en el contexto y no en la base de datos...
            let newHero = MOHero(context: context)
            newHero.identifier = hero.id
            newHero.name = hero.name
            newHero.info = hero.description
            newHero.photo = hero.photo
            newHero.favorite = hero.favorite ?? false
        }
        // ... hasta que no guardamos
        saveContext()
    }
    // Inserta localizaciones de heroes en contexto y persiste en BBDD con saveContext()
    func insert(locations: [HeroLocationDTO]){
        for location in locations {
            let newLocation = MOHeroLocation(context: context)
            newLocation.identifier = location.id
            newLocation.latitude = location.latitude
            newLocation.longitude = location.longitude
            newLocation.date = location.date
            
            // asocia un héroe a la localización
            if let identifier = location.hero?.id {
                // Trae de la BBDD el heroe con ese id y lo metes en newLocation.hero
                let predicate = NSPredicate(format: "identifier == %@", identifier)
                newLocation.hero = fetchHeroes(filter: predicate).first
            }
        }
        saveContext()
    }
    
    func insert(transformations: [TransformationDTO]){
        for transformation in transformations {
            let newTransformation = MOTransformation(context: context)
            newTransformation.identifier = transformation.id
            newTransformation.name = transformation.name
            newTransformation.info = transformation.description
            newTransformation.photo = transformation.photo
            
            //Asocia un heroe a una transformacion
            if let identifier = transformation.hero?.id {
                let predicate = NSPredicate(format: "identifier == %@", identifier)
                newTransformation.hero = fetchHeroes(filter: predicate).first
            }
            
        }
        saveContext()
    }
    
    func clearBBDD(){
        // Quitamos los cambios pendientes que haya en el contexto
        context.rollback()
        
        // Van contra la BBDD = no pasan por el contexto sino que actuan directamente con la BBDD
        // creamos los procesos batch de borrado, estos procesos se ejecutan  contra el Store, la BBDD  y no en el contexto.
        let deleteHeroes = NSBatchDeleteRequest(fetchRequest: MOHero.fetchRequest())
        let deleteHeroLocations =  NSBatchDeleteRequest(fetchRequest: MOHeroLocation.fetchRequest())
        let deleteHeroTransformation =  NSBatchDeleteRequest(fetchRequest: MOTransformation.fetchRequest())
        
        for task in [deleteHeroes,deleteHeroLocations]{
            do {
                try context.execute(task)
            } catch {
                debugPrint("Ha habido un error borrando la BBDD\(error)")
            }
        }

    }
    
    
}
