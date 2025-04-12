//
//  LocationDTO.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 11/4/25.
//

import Foundation

struct HeroLocationDTO: Codable {
    let id: String
    let longitude: String?
    let latitude: String?
    let date: String?
    let hero: HeroDTO?
    
    enum CodingKeys: String, CodingKey  {
        case id
        case longitude = "longitud"
        case latitude = "latitud"
        case date = "dateShow"
        case hero
    }
    
}
