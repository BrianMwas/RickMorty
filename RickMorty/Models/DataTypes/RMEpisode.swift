//
//  RMEpisode.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import Foundation

/// Episode model
struct RMEpisode: Codable {
    let id: String
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
