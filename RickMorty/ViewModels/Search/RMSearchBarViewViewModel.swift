//
//  RMSearchBarViewViewModel.swift
//  RickMorty
//
//  Created by Brian on 18/04/2023.
//

import Foundation

final class RMSearchBarViewViewModel {
    private let type: RMSearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
        
        var choices: [String] {
            switch self {
            case .status:
                return ["alive", "dead", "unknown"]
            case .gender:
                return ["male", "female", "genderless", "unknown"]
            case .locationType:
                return ["cluster", "planet", "microverse"]
            }
        }
    }
    
    // MARK: - Init
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
    
    // MARK: - Public
    public var hasDynamicOptions: Bool  {
        switch self.type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
        
    public var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .episode:
            return []
        case .location:
            return [.locationType]
        }
    }
    
    
    public var searchPlaceholderText: String{
        switch self.type {
        case .character:
            return "Character name"
        case .episode:
            return "Episode title"
        case .location:
            return "Location name"
        }
    }
}
