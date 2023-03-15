//
//  RMCharacter.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import Foundation

/// Character model
struct RMCharacter:Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMCharacterGender
    let origin: RMOrigin
    let location: RMSingleLocation
    let image: String
    let episode :[String]
    let url: String
    let created: String
}


