//
//  HeroCell.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 9/4/25.
//

import UIKit

class HeroCell: UICollectionViewCell {
    
    static let identifier = String(describing: HeroCell.self)

    // MARK: - Outlets
    @IBOutlet weak private var heroImage: AsyncImage!
    @IBOutlet weak private var heroNameLabel: UILabel!
    
    // MARK: - Configuration
    func configure(with hero: Hero) {
        
        heroImage.setImage(hero.photo ?? "")
        heroNameLabel.text = hero.name
        layer.cornerRadius = 12
        
    
    }
    

}
