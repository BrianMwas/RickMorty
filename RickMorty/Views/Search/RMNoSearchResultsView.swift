//
//  RMNoSearchResultsView.swift
//  RickMorty
//
//  Created by Brian on 18/04/2023.
//

import UIKit

class RMNoSearchResultsView: UIView {
    private let viewModel =  RMNoSearchBarViewViewModel()
    
    private let iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemBlue
        
        return view
    }()
    
    private let label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 16, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(iconView, label)
        addConstraints()
        configure()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 100),
            iconView.heightAnchor.constraint(equalToConstant: 100),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
//            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10)
        ])
    }
    
    private func configure() {
        label.text = viewModel.title
        iconView.image = viewModel.image
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
