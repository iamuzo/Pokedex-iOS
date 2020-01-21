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
        // I wish apple had written/defined this as
        // `enum CodingKeys: CodingKey, String` because
        // case refers to the codingKey we want to use
        // while its value refers to the string used in the API
        case frontDefault = "front_default"
    }
}
