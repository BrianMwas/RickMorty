//
//  RMEpisodeDetailViewCell.swift
//  RickMorty
//
//  Created by Brian on 04/04/2023.
//

import UIKit

/// VC used to show details about an episode
final class RMEpisodeDetailViewController: UIViewController {
    private let viewModel: RMEpisodeDetailViewViewModel
    
    // MARK: - Init
    init(url: URL?) {
        self.viewModel = .init(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemCyan
        viewModel.fetchEpisodeData()
    }
}
