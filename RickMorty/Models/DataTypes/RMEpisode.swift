//
//  RMEpisode.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import Foundation

/// Episode model
struct RMEpisode: Codable, RMEpisodeDataRender {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
