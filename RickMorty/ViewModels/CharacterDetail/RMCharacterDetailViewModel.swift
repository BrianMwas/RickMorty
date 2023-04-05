//
//  RMCharacterDetailViewModel.swift
//  RickMorty
//
//  Created by Brian on 27/03/2023.
//

import UIKit

final class RMCharacterDetailViewModel {
    private let character: RMCharacter
    
    public var episodes: [String] {
        character.episode
    }
    
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModel: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes (viewModel: [RMCharacterEpisodeViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    // MARK: Init
    
    init(character: RMCharacter) {
        self.character = character
        setupSections()
    }
    
    private func setupSections() {
        
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: character.image))),
            .information(viewModel: [
                .init(type: .status, value: character.status.text ),
                .init(type: .gender, value: character.gender.rawValue ),
                .init(type: .type, value: character.type ),
                .init(type: .species, value: character.species ),
                .init(type: .created, value: character.created ),
                .init(type: .origin, value: character.origin.name ),
                .init(type: .location, value: character.location.name),
                .init(type: .episodeCount, value: "\(character.episode.count)")
            ]),
            .episodes(viewModel: character.episode.compactMap({ url in
                return RMCharacterEpisodeViewCellViewModel(episodeDataUrl: URL(string: url))
            })),
        ]
    }
    
    public var  requestURL: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    // MARK: - Layouts
    
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)), subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    public func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(150)), subitems: [item])
    
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
