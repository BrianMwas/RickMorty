//
//  RMSearchResultsViewModel.swift
//  RickMorty
//
//  Created by Brian on 01/05/2023.
//

import Foundation

enum RMSearchResultsViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
    case episodes([RMCharacterEpisodeViewCellViewModel])
}
