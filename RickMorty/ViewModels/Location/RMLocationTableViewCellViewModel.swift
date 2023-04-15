//
//  RMLocationTableCellViewViewModel.swift
//  RickMorty
//
//  Created by Brian on 15/04/2023.
//

import Foundation


struct RMLocationTableViewCellViewModel: Hashable, Equatable {
    
    
    private var location: RMLocation
    
    init(location: RMLocation) {
        self.location = location
    }
    
    public var name: String {
        return location.name
    }
    
    public var dimension: String {
        return location.dimension
    }
    
    public var type: String {
        return location.type
    }
    
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
        hasher.combine(location.id)
        hasher.combine(dimension)
    }
}
