//
//  HeroesListViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 9/4/25.
//

import Foundation

enum HeroListState {
    case error(reason: String)
    case loading
    case success
}

class HeroesListViewModel {
    
    let onStateChanged = Binding<HeroListState>()
    private let useCase: GetHeroesUseCaseProtocol
    
    init(useCase: GetHeroesUseCaseProtocol {
        self.useCase = useCase
    })
    
}
