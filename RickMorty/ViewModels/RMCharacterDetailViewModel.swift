//
//  RMCharacterDetailViewModel.swift
//  RickMorty
//
//  Created by Brian on 27/03/2023.
//

import Foundation

final class RMCharacterDetailViewModel {
    private let character: RMCharacter
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
