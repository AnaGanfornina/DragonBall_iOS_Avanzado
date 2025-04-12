//
//  TransformationDetailBuilder.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 12/4/25.
//

import UIKit

final class TransformationDetailBuilder {
    private var viewModel: TransformationDetailViewModel
    
    init(transformation: HeroTransformation) {
        self.viewModel = TransformationDetailViewModel(transformation: transformation)
    }
    
    func build() -> UIViewController {
        TransformationDetailViewController(viewModel: viewModel)
    }
}


