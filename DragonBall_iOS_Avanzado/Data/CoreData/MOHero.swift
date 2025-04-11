//
//  MOHero+CoreDataProperties.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 9/4/25.
//
//

import Foundation
import CoreData

@objc(MOHero)
public class MOHero: NSManagedObject {

}

extension MOHero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOHero> {
        return NSFetchRequest<MOHero>(entityName: "Hero")
    }

    @NSManaged public var photo: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var identifier: String?
    // La relacion con el hero lo hace como otro atributo mas
    @NSManaged public var locations: Set<MOHeroLocation> // Usamos set en vez de un array para que no haya duplicados
}

// MARK: Generated accessors for locations
extension MOHero {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: MOHeroLocation)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: MOHeroLocation)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)

}

extension MOHero : Identifiable {

}

extension MOHero {
    // Mapper para crear un objeto Hero de Domain a partir de MOHero
    func mapToHero() -> Hero {
        Hero(
            id: self.identifier ?? "",
            favorite: self.favorite,
            name: self.name,
            description: self.info,
            photo: self.photo)
    }

}
