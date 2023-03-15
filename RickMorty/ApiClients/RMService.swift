//
//  RMService.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import Foundation

/// Primary API service Object to get Rick and Morty data.
final class RMService {
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Privatised instance
    private init() {}
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: The request details
    ///   - completion: Callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
