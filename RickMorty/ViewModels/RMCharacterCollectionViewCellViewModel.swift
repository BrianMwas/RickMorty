//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickMorty
//
//  Created by Brian on 21/03/2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
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
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
