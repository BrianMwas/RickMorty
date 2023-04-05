//
//  RMEndpoint.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import Foundation


/// Represents Unique endpoint
@frozen enum RMEndpoint:  String, CaseIterable, Hashable {
    /// Endpoint to get character detail
    case character
    /// Endpoint to get location detail
    case location
    /// Endpoint to get episode detail.
    case episode
}
