//
//  RMSearchViewController.swift
//  RickMorty
//
//  Created by Brian on 06/04/2023.
//

import UIKit

class RMSearchViewController: UIViewController {
    struct Config {
        enum `Type` {
            case character
            case episode
            case location
            
            var title: String {
                switch self {
                case .character: // name | status | gender
                    return "Character"
                case .episode: // name
                    return "Episode"
                case .location: // name | type
                    return "Location"
                }
            }
        }
        
        let type: `Type`
    }
    
    private let config: Config
    
    // MARK - Init
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    // NARK: - Lifecycle Owner
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
    }
}
