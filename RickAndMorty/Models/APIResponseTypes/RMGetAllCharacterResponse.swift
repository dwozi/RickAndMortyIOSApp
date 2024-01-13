//
//  RMGetCharacterResponse.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 9.01.2024.
//

import Foundation
struct RMGetAllCharacterResponse : Codable{
    struct Info : Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
        
    }
    let info: Info
    let results : [RMCharacter]
}



