//
//  DetailHeroBuilder.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 11/4/25.
//

import UIKit

final class heroDetailBuilder {
    
    private var viewModel: HeroDetailViewModel
    
    init(hero: Hero) {
        let useCase = HeroDetailUseCase()
        self.viewModel = HeroDetailViewModel(useCase: useCase, hero: hero)
    }

    func build() -> UIViewController {
        HeroDetailViewController(viewModel: viewModel)
    }
}
