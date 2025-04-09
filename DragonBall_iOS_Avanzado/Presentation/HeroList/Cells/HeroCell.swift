//
//  HeroCell.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 9/4/25.
//

import UIKit

class HeroCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak private var heroImage: UIImageView!
    @IBOutlet weak private var heroNameLabel: UILabel!
    
    // MARK: - Configuration
    func configure(with hero: Hero) {
        // heroImage.image
        heroNameLabel.text = hero.name
        // TODO: Posibilidad de añadir radius corner layer.cornerRadius = 12
    }
    

}
