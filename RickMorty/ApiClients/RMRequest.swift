//
//  RMRequest.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import Foundation

/// Object that represents a single API call.
final class RMRequest {
    /// Base url
    /// Endpoint to reach
    /// Path components
    /// Query parameters
    ///
    private struct Constants  {
        static let baseUrl = "https://rickandmortyapi.com/api/"
    }
    
    /// Desired endpoint
    private let endpoint: RMEndpoint
    
    /// Path components for the API
    private let pathComponents: [String]
    
    /// Queries for the API.
    private let queryParameters: [URLQueryItem]
    
    /// Desired http method
    public let httpMethod = "GET"
    
    /// Constructed URLfor the request in string format.
    private var urlString: String {
        var path = Constants.baseUrl
        path += "/"
        path += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                path += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            path += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            path += argumentString
        }
        
        return path
    }
    
    /// Constructed URL for accessing information for RickandMorty API.
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Construct Request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection of query parameters
    public init(endpoint: RMEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
