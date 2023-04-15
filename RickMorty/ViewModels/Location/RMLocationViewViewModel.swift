//
//  RMLocationViewViewModel.swift
//  RickMorty
//
//  Created by Brian on 15/04/2023.
//

import Foundation


final class RMLocationViewViewModel {
    private var locations: [RMLocation] = []
    
    // Location response info
    // Will contain next URL if present
    private var cellViewModels: [String]  = []
    
    init() {
        
    }
    
    public func fetchLocations() {
        RMService.shared.execute(.listLocationsRequest, expecting: String.self) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
