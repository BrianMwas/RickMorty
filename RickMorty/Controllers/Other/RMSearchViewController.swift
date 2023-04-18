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
        
    private let searchView: RMSearchView
    
    private var viewModel: RMSearchViewViewModel
    
    // MARK - Init
    init(config: Config) {
        let vm = RMSearchViewViewModel(config: config)
        self.viewModel = vm
        self.searchView = .init(frame: .zero, viewModel: RMSearchViewViewModel(config: config))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // NARK: - Lifecycle Owner
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.addSubview(searchView)
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapExecuteSearch))
    }
    
    @objc
    private func didTapExecuteSearch() {
        // viewModel.executeSearch()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
