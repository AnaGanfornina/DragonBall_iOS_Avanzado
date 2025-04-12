//
//  DetailHeroBuilder.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 11/4/25.
//

import UIKit

final class HeroDetailBuilder {
    
    private var viewModel: HeroDetailViewModel
    
    init(hero: Hero) {
        let useCaseLocation = GetHeroLocationsUseCase()
        let useCaseTransformation = GetHeroTransformationUseCase()
        self.viewModel = HeroDetailViewModel(hero: hero,
                                             useCaseLocation: useCaseLocation,
                                             useCaseTransformation: useCaseTransformation)
    }

    func build() -> UIViewController {
        HeroDetailViewController(viewModel: viewModel)
    }
}
