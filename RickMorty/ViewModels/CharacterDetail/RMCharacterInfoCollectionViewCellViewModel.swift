//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickMorty
//
//  Created by Brian on 31/03/2023.
//

import UIKit


final class RMCharacterInfoCollectionViewCellViewModel {
    private let type: `Type`
    private let value: String
    
    static let dateFormatter: DateFormatter = {
        // Format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        // Format
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        
        return formatter
    }()
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty { return "None" }
        if type == .created {
            print("Date is \(value)")
        }
        if let date = Self.dateFormatter.date(from: value),
           type == .created {
            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case species
        case created
        case origin
        case episodeCount
        case type
        case location
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return.systemBlue
            case .gender:
                return .systemRed
            case .species:
                return .systemGreen
            case .created:
                return .systemMint
            case .origin:
                return .systemPink
            case .episodeCount:
                return .systemOrange
            case .type:
                return .systemPurple
            case .location:
                return .systemYellow
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status,
                    .gender,
                    .species,
                    .origin,
                    .type,
                    .created,
                    .location:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }
    
    init(type: `Type`, value: String) {
        self.type = type
        self.value = value
    }
}
