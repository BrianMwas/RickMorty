//
//  RMSettingsOption.swift
//  RickMorty
//
//  Created by Brian on 14/04/2023.
//

import Foundation

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiRef
    case viewSeries
    case viewCode
    
    var targetURL: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://iosacademy.io/contact")
        case .terms:
            return URL(string: "https://iosacademy.io/terms/")
        case .privacy:
            return URL(string: "https://iosacademy.io/privacy/")
        case .apiRef:
            return URL(string: "https://rickandmortyapi.com")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/watch?v=EZpZDuOAFKE&list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")
        case .viewCode:
            return URL(string: "https://github.com/brianMwas")
        }
    }
    
    public var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiRef:
            return "API Reference"
        case .viewSeries:
            return "View Series"
        case .viewCode:
            return "View Code"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemRed
        case .contactUs:
            return .systemBlue
        case .terms:
            return .systemOrange
        case .privacy:
            return .systemMint
        case .apiRef:
            return .systemPink
        case .viewSeries:
            return .systemGreen
        case .viewCode:
            return .systemPurple
        }
    }
    
    public var iconImage: UIImage? {
        switch self {
        case .rateApp:
            let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            image?.withTintColor(.white)
            return image
        case .contactUs:
            let image =  UIImage(systemName: "paperplane")?.withRenderingMode(.alwaysTemplate)
            image?.withTintColor(.white)
            return image
        case .terms:
            let image =  UIImage(systemName: "doc")?.withRenderingMode(.alwaysTemplate)
            image?.withTintColor(.white)
            return image
        case .privacy:
            let image = UIImage(systemName: "lock")?.withRenderingMode(.alwaysTemplate)
            image?.withTintColor(.white)
            return image
        case .apiRef:
            let image = UIImage(systemName: "list.clipboard")?.withRenderingMode(.alwaysTemplate)
            image?.withTintColor(.white)
            return image
        case .viewSeries:
            let image = UIImage(systemName: "tv.fill")?.withRenderingMode(.alwaysTemplate)
            image?.withTintColor(.white)
            return image
        case .viewCode:
            let image = UIImage(systemName: "hammer")?.withRenderingMode(.alwaysTemplate)
            image?.withTintColor(.white)
            return image
        }
    }
}
