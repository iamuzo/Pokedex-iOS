//
//  Pokemon.swift
//  Pokedex
//
//  Created by Uzo on 1/20/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let weight: Int
    let sprites: SpriteObject
}

struct SpriteObject: Codable {
    let frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
