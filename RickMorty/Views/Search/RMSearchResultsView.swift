//
//  RMSearchResultsView.swift
//  RickMorty
//
//  Created by Brian on 02/05/2023.
//

import UIKit

/// Show search resutls view (table or collection as needed)
final class RMSearchResultsView: UIView {
    
    private var viewModel: RMSearchResultsViewModel? {
        didSet {
            self.processViewModel()
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
        table.isHidden = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        addSubview(tableView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func processViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        switch viewModel {
        case .characters(let viewModels):
            setupCollectionView()
        case .locations(let array):
            setupTableView()
        case .episodes(let array):
            setupCollectionView()
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupCollectionView() {
        
    }
    
    private func setupTableView() {
        
    }
    
    public func configure(with viewModel: RMSearchResultsViewModel) {
        self.viewModel = viewModel
    }
}
