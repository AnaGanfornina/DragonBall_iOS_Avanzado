//
//  TransformationDetailViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 12/4/25.
//
/*
enum TransformationDetailState: Equatable {
    case error(reason: String)
    case loading
    case succcess
}
*/
final class TransformationDetailViewModel {
    // let onStateChanged = Binding<TransformationDetailState>()
    private(set) var transformation: HeroTransformation?
    
    init(transformation: HeroTransformation){
        self.transformation = transformation
    
    }
    
    
}

