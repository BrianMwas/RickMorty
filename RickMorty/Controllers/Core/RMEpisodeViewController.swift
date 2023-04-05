//
//  RMEpisodeViewController.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import UIKit

/// Controller to show episodes and their details.
final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {
    private let episodeListView = RMEpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episodes"
    
        setupView()
    }
    
    private func setupView() {
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - RMCharacterListViewDelegate
//    func rmEpisodeListView(_ characterListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
//        // Open detail controller for that character
//        let viewModel = RMEpisodeDetailViewModel(episode: episode)
//        let episodeDetailVC = RMDetailViewController(viewModel: viewModel)
//        episodeDetailVC.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(episodeDetailVC, animated: true)
//    }
    
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
//        let viewModel = RMEpisodeDetailViewViewModel(url: URL(string: episode.url))
        let episodeDetailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        episodeDetailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(episodeDetailVC, animated: true)
    }
}
