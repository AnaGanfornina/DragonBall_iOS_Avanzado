//
//  MOTransformation+CoreDataProperties.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 12/4/25.
//
//

import Foundation
import CoreData

@objc(MOTransformation)
public class MOTransformation: NSManagedObject {

}

extension MOTransformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOTransformation> {
        return NSFetchRequest<MOTransformation>(entityName: "Transformation")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var name: String?
    @NSManaged public var info: String?
    @NSManaged public var photo: String?
    @NSManaged public var hero: MOHero?

}

extension MOTransformation : Identifiable {

}
extension MOTransformation {
    // Mapper para crear un objeto Transformation de Domain a partir de MOTransformation
    
    func mapToTransformation() -> HeroTransformation {
        HeroTransformation(
            id: self.identifier ?? "",
            name: self.name,
            photo: self.photo,
            description: self.info,
            hero: self.hero?.mapToHero())
    }
}
