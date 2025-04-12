//
//  TransformationCell.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 12/4/25.
//

import UIKit

class TransformationCell: UICollectionViewCell {
    static let identifier = String(describing: TransformationCell.self)
    
    // MARK: - Outlets
    @IBOutlet weak private var transformationImage: AsyncImage!
    @IBOutlet weak private var transformationNameLabel: UILabel!
    
    // MARK: - Configuration
    func configure(whith transformation: HeroTransformation){
        
        transformationImage.setImage(transformation.photo ?? "")
        transformationNameLabel.text = transformation.name
        layer.cornerRadius = 12
    }
}
