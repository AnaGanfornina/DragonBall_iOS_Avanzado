//
//  HeroesViewModelTest.swift
//  DragonBall_iOS_AvanzadoTests
//
//  Created by Ana on 13/4/25.
//
/*
import XCTest
@testable import DragonBall_iOS_Avanzado

class MockHeroesUseCase: GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[Hero], GetHeroesError>) -> Void) {
        do {
            let urlData = try XCTUnwrap(Bundle(for: ApiProviderTest.self).url(forResource: "Heroes", withExtension: "json"))
            let data = try Data(contentsOf: urlData)
            let response = try JSONDecoder().decode([HeroDTO].self, from: data)
            completion(.success(response.map({$0.mapToHero()})))
        } catch {
            completion(.failure(GetHeroesError(reason: String(describing: error))))
        }
    }
}



final class HeroesViewModelTests: XCTestCase {
    
    var sut: HeroesListViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testLoadData() {
        // Given
        var expectedHeroes: [Hero] = []
        sut = HeroesListViewModel(useCase: MockHeroesUseCase(), storeData: .sharedTesting)
        
        
        // When
        // Usamod una expectation para esperar a que nos informe de los cambios de estado el viewModel
        let expectation = expectation(description: "ViewModel load heroes and inform")
        sut.run { [weak self] state in
            switch state {
            case .dataUpdated:
                expectedHeroes = self?.sut.fetchHeroes() ?? []
                expectation.fulfill()
            case .errorLoadingHeroes(error: _):
                XCTFail("Waiting for success")
            }
        }
        sut.loadData()
        
        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(expectedHeroes.count, 15)
    }

}

// EXtensio de ApiHero para mapearlo al modelo del Domain Hero
extension HeroDTO {
    func mapToHero() -> Hero {
        Hero.init(id: self.id,
                  name: self.name,
                  description: self.description,
                  photo: self.photo)
    }
 
 
}
*/
