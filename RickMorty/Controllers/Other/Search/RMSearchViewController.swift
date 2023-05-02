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
            
            var endpoint: RMEndpoint {
                switch self {
                case .character: return .character
                case .episode: return .episode
                case .location: return .location
                }
            }
            
            var searchResultsResponseType: Any.Type {
                switch self {
                case .character: return RMGetAllCharactersResponse.self
                case .episode: return RMGetAllEpisodesResponse.self
                case .location: return RMGetLocationsResponse.self
                }
            }
            
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
        self.searchView = .init(frame: .zero, vm: vm)
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
        searchView.delegate = self
    }
    
    @objc
    private func didTapExecuteSearch() {
         viewModel.executeSearch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchView.presentKeyboard()
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


extension RMSearchViewController: RMSearchViewDelegate {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchBarViewViewModel.DynamicOption) {
        let vc = RMSearchOptionPickerViewController(option: option) { [weak self] selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
            }
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }
}
