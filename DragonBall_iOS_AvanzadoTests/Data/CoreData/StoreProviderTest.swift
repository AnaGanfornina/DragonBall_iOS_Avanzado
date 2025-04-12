//
//  StoreProviderTest.swift
//  DragonBall_iOS_AvanzadoTests
//
//  Created by Ana on 12/4/25.
//

import XCTest
@testable import DragonBall_iOS_Avanzado

final class StoreProviderTest: XCTestCase {
    
    private var sut: StoreDataProvider!
    private var hero: HeroDTO!
    

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = .sharedTesting
        hero = createHero()
        
    }

    override func tearDownWithError() throws {
       try super.tearDownWithError()
        sut.clearBBDD()
        sut = nil
    }
    
    /// Función para crear un hero para los test
    private func createHero(whith name: String = "Name") -> HeroDTO{
        HeroDTO(id: UUID().uuidString, // UUID.uuidString genera un número aleatorio
                favorite: true,
                name: name,
                description: "description",
                photo: "photo")
    }
    
    private func createTransformation() -> TransformationDTO{
        TransformationDTO(
            id:  UUID().uuidString,
            name: "Transformacion",
            description: "Soy una transformacion",
            photo: "photo",
            hero:  hero)
    }
    
    func test_Insert_Heroes() throws {
        // Given
        
        let expectedHero = createHero()
        
        //Nos aseguramos que la base de datos esté vacía
        let initialCount = sut.fetchHeroes(filter: nil).count
        
        // When
        
        sut.insert(heroes: [expectedHero])
        
        // Then
        
        let finalCount = sut.fetchHeroes(filter: nil).count
        XCTAssertEqual(initialCount, 0)
        XCTAssertEqual(finalCount, 1)
        
        let hero = try XCTUnwrap(sut.fetchHeroes(filter: nil).first) // Hace el test de que el objeto no es nil aunque es opicional
        XCTAssertEqual(hero.name, expectedHero.name)
        XCTAssertEqual(hero.info, expectedHero.description)
        XCTAssertEqual(hero.photo, expectedHero.photo)
        XCTAssertTrue(hero.favorite)
        XCTAssertNotNil(hero.identifier)
    }
    
    func test_Insert_Transformations() throws {
        // Given
        
        let expectedTransformation = createTransformation()
        sut.insert(heroes: [hero])
        let initialCount = sut.fetchTransformation(filter: nil).count
        
        // When
        sut.insert(transformations: [expectedTransformation])
        
        // Then
        
        let finalCount = sut.fetchTransformation(filter: nil).count
        XCTAssertEqual(initialCount, 0)
        XCTAssertEqual(finalCount, 1)
        
        let transformation = try XCTUnwrap(sut.fetchTransformation(filter: nil).first)
        XCTAssertEqual(transformation.name, expectedTransformation.name)
        XCTAssertEqual(transformation.info, expectedTransformation.description)
        XCTAssertEqual(transformation.photo, expectedTransformation.photo)
        XCTAssertNotNil(transformation.identifier)
        
        XCTAssertEqual(transformation.hero?.name, expectedTransformation.hero?.name)
    }
    
    func test_clearBBDD() {
        // Given
        sut.insert(heroes: [createHero(),createHero()])
        let initialCount = sut.fetchHeroes(filter: nil).count

        // When
        
        sut.clearBBDD()

        // Then
        
        let finalCount = sut.fetchHeroes(filter: nil).count
        XCTAssertEqual(initialCount, 2)
        XCTAssertEqual(finalCount, 0)
    }
    
    func test_fetchHeroes_ReturnHero() {
        // Given

        let initialCount = sut.fetchHeroes(filter: nil).count
        sut.insert(heroes: [createHero(),createHero()])
        

        // When
        
        let finalCount = sut.fetchHeroes(filter: nil).count

        // Then
        XCTAssertEqual(initialCount, 0)
        XCTAssertEqual(finalCount, 2)
   
    }
    
    func test_fetchTransformation_ReturnTransformatoin() {
        // Given

        let initialCount = sut.fetchTransformation(filter: nil).count
        sut.insert(transformations: [createTransformation(),createTransformation()])
        

        // When
        
        let finalCount = sut.fetchTransformation(filter: nil).count

        // Then
        XCTAssertEqual(initialCount, 0)
        XCTAssertEqual(finalCount, 2)
   
    }

}

