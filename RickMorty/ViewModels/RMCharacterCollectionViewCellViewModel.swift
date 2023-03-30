//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickMorty
//
//  Created by Brian on 21/03/2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
 
    
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
    
    
                
    init(characterName: String, characterStatus: RMCharacterStatus, characterURL: URL?) {
        self.characterImageURL =  characterURL
        self.characterName = characterName
        self.characterStatus = characterStatus
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }

    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: Abstract to image loader
        guard let url = characterImageURL else {
            completion(.failure(URLError(URLError.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(url) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    // MARK: - Hashable
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
}
