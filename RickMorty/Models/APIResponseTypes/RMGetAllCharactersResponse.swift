//
//  RMGetAllCharactersResponse.swift
//  RickMorty
//
//  Created by Brian on 16/03/2023.
//

import Foundation


struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let results: [RMCharacter]
    let info: Info
}
