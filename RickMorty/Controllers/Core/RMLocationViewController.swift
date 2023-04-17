//
//  RMLocationViewController.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import UIKit

/// Controller to show location information.
final class RMLocationViewController: UIViewController, RMLocationViewViewDelegate, RMLocationViewDelegate {
    
    private let primaryView = RMLocationView()
    
    private let viewModel = RMLocationViewViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(primaryView)
        view.backgroundColor = .systemBackground
        title = "Location"
        addSearchButton()
        addConstraints()
        viewModel.delegate = self
        primaryView.delegate = self
        viewModel.fetchLocations()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc
    private func didTapSearch() {
        
    }
    
    // MARK: - RMLocationViewDelegate
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation) {
        let vc = RMLocationDetailViewController(location: location)
        print("We have the location details here \(location)")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Location View delegate
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}
