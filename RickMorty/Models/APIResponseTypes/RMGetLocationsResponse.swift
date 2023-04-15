//
//  RMGetLocationsResponse.swift
//  RickMorty
//
//  Created by Brian on 15/04/2023.
//

import Foundation


struct RMGetLocationsResponse : Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String?
    }
    let results: [RMLocation]
    let info: Info
}
