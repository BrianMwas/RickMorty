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
    
    private let cacheManager = RMAPICacheManager()
    
    /// Privatised instance
    private init() {}
    
    enum RMServiceError: Error {
        case failedToCreateRequest
    }
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: The request details
    ///    - expecting: Data type I am supposed to get.
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            if let cachedData = cacheManager.cacheResponse(for: request.endpoint, url: request.url) {
                print("Using cached API response")
                do {
                    let result = try JSONDecoder().decode(type.self, from: cachedData)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
                return
            }
            guard let urlRequest = self.request(from: request) else {
                completion(.failure(RMServiceError.failedToCreateRequest))
                return
            }
            
            
            
            let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(error ?? RMServiceError.failedToCreateRequest))
                    return
                }
                
                // Decode json
                do {
                    let result = try JSONDecoder().decode(type.self, from: data)
                    self?.cacheManager.setCache(
                        for: request.endpoint,
                        url: request.url,
                        data: data
                    )
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
    }
    
    // MARK: - Private
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
