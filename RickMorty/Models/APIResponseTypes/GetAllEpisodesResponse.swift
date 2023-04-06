//
//  GetAllEpisodesResponse.swift
//  RickMorty
//
//  Created by Brian on 06/04/2023.
//

import Foundation


struct RMGetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String?
    }
    let results: [RMEpisode]
    let info: Info
}
