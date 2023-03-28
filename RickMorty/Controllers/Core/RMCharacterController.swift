//
//  RMVCharacterController.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import UIKit

/// Controller to show and search for characters
final class RMCharacterController: UIViewController, RMCharacterListViewDelegate {
    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
    
        setupView()
        
    }
    
    private func setupView() {
        characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - RMCharacterListViewDelegate
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        // Open detail controller for that character
        let viewModel = RMCharacterDetailViewModel(character: character)
        let characterDetailVC = RMDetailViewController(viewModel: viewModel)
        characterDetailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
}
