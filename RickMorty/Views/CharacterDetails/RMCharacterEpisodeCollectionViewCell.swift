//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickMorty
//
//  Created by Brian on 31/03/2023.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    private let seasonLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
   
        return label
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
   
        return label
    }()
    
    private let airDateLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
   
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayer()
        contentView.addSubviews(seasonLabel, nameLabel, airDateLabel)
        setUpConstraints()
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayer() {
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            seasonLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        airDateLabel.text = nil
        nameLabel.text = nil
    }
    
    public func configure(with viewModel: RMCharacterEpisodeViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
            self?.airDateLabel.text = "Aired on" + data.air_date
            self?.nameLabel.text = data.name
            self?.seasonLabel.text = "Episode: " + data.episode
        }
        viewModel.fetchEpisode()
        contentView.layer.borderColor = viewModel.borderColor.cgColor
    }
}
