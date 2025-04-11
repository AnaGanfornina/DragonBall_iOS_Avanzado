//
//  HeroesListBuilder.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 9/4/25.
//

import UIKit

final class HeroesListBuilder {
    func build() -> UIViewController {
        
        let useCase = GetHeroesUseCase()
        let viewModel = HeroesListViewModel(useCase: useCase)
        return HeroListViewController(viewModel: viewModel)
    }
}
