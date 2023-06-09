//
//  RMEpisodeDetailViewCell.swift
//  RickMorty
//
//  Created by Brian on 04/04/2023.
//

import UIKit

/// VC used to show details about an episode
final class RMEpisodeDetailViewController: UIViewController, RMEpisodeDetailViewViewModelDelegate, RMEpisodeDetailViewDelegate {
    
    
    private let viewModel: RMEpisodeDetailViewViewModel
    
    private let detailView = RMEpisodedetailView()
    
    // MARK: - Init
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(url: url)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.addSubview(detailView)
        detailView.delegate = self
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc
    private func didTapShare() {
        
    }
    
    func rmEpisodedetailView(_ detailView: RMEpisodedetailView, didSelect character: RMCharacter) {
        let vc = RMDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Delegate
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}
