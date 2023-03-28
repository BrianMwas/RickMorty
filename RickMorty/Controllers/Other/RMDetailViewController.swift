//
//  RMDetailViewController.swift
//  RickMorty
//
//  Created by Brian on 27/03/2023.
//

import UIKit

final class RMDetailViewController: UIViewController {
    private let viewModel: RMCharacterDetailViewModel
    init(viewModel: RMCharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
}
