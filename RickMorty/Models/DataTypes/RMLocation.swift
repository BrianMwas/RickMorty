//
//  RMLocation.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import Foundation

/// Location model 
struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
