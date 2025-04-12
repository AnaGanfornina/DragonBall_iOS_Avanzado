//
//  TransformationDTO.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 12/4/25.
//


import Foundation

struct TransformationDTO: Codable{
    let id: String
    let name: String?
    let description: String?
    let photo: String?
    let hero: HeroDTO?
}

