//
//  RMLocationDetailViewViewModel.swift
//  RickMorty
//
//  Created by Brian on 17/04/2023.
//

import Foundation

protocol RMLocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class RMLocationDetailViewViewModel {
    private let endpointURL: URL?
    private var dataTuple: (location: RMLocation, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    
    public private(set) var cellViewModels: [SectionType] = []
    
    public weak var delegate: RMLocationDetailViewViewModelDelegate?
    
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }
    
    enum SectionType {
        case information(viewModel: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    // MARK: - Init
    init(url: URL?) {
        self.endpointURL = url
    }
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else  {
            return
        }
        let location = dataTuple.location
        let characters = dataTuple.characters
    
        var createdString = ""
    
        if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
    
    
        cellViewModels = [
            .information(
                viewModel:  [
                  .init(title: "Location Name", value: location.name),
                  .init(title: "Type", value: location.type),
                  .init(title: "Dimension", value: location.dimension),
                  .init(title: "Created", value: createdString)
            ]),
            .characters(viewModel: characters.compactMap({ character in
                return RMCharacterCollectionViewCellViewModel(characterName: character.name, characterStatus: character.status, characterURL: URL(string: character.image))
            }))
        ]
    }
    
    /// Fetch location data
    public func fetchLocationData() {
        guard let url = endpointURL, let request = RMRequest(url: url) else {
            return
        }
    
        RMService.shared.execute(request, expecting: RMLocation.self) { [weak self] result in
            switch result {
            case .success(let model):
                print(String(describing: model))
                self?.fetchRelatedCharacters(location: model)
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    private func fetchRelatedCharacters(location: RMLocation) {
        let requests: [RMRequest] = location.residents.compactMap { url in
            return URL(string: url)
        }.compactMap { url in
            return RMRequest(url: url)
        }
    
        /// Allows you to kick off a list of parallel request and get notified once all of them
        /// are done.
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    print("Failed")
                    break
                }
            }
        }
    
        group.notify(queue: .main) {
            self.dataTuple = (
                location,
                characters
            )
        }
    }
}


//private let episodeURL: URL?
//private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
//    didSet {
//        createCellViewModels()
//        delegate?.didFetchEpisodeDetails()
//    }
//}
//
//enum SectionType {
//    case information(viewModel: [RMEpisodeInfoCollectionViewCellViewModel])
//    case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
//}
//
//public weak var delegate: RMEpisodeDetailViewViewModelDelegate?
//
//
//public private(set) var cellViewModels: [SectionType] = []
//
//public func character(at index: Int) -> RMCharacter? {
//    guard let dataTuple = dataTuple else {
//        return nil
//    }
//    return dataTuple.characters[index]
//}
//
//
//// MARK: - Init
//init(url: URL?) {
//    self.episodeURL = url
//}
//
//// MARK: - Public
//
//
//// MARK: - Private
//private func createCellViewModels() {
//    guard let dataTuple = dataTuple else  {
//        return
//    }
//    let episode = dataTuple.episode
//    let characters = dataTuple.characters
//
//    var createdString = ""
//
//    if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: episode.created) {
//        createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
//    }
//
//
//    cellViewModels = [
//        .information(
//            viewModel:  [
//              .init(title: "Episode Name", value: episode.name),
//              .init(title: "Air Date", value: episode.air_date),
//              .init(title: "Episode", value: episode.episode),
//              .init(title: "Created", value: createdString)
//        ]),
//        .characters(viewModel: characters.compactMap({ character in
//            return RMCharacterCollectionViewCellViewModel(characterName: character.name, characterStatus: character.status, characterURL: URL(string: character.image))
//        }))
//    ]
//}
//
//public func fetchEpisodeData() {
//    guard let url = episodeURL, let request = RMRequest(url: url) else {
//        return
//    }
//
//    RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
//        switch result {
//        case .success(let model):
//            print(String(describing: model))
//            self?.fetchRelatedCharacters(episode: model)
//        case .failure(let failure):
//            print(String(describing: failure))
//        }
//    }
//}
//
//private func fetchRelatedCharacters(episode: RMEpisode) {
//    let requests: [RMRequest] = episode.characters.compactMap { url in
//        return URL(string: url)
//    }.compactMap { url in
//        return RMRequest(url: url)
//    }
//
//    /// Allows you to kick off a list of parallel request and get notified once all of them
//    /// are done.
//    let group = DispatchGroup()
//    var characters: [RMCharacter] = []
//    for request in requests {
//        group.enter()
//        RMService.shared.execute(request, expecting: RMCharacter.self) { result in
//            defer {
//                group.leave()
//            }
//            switch result {
//            case .success(let model):
//                characters.append(model)
//            case .failure:
//                print("Failed")
//                break
//            }
//        }
//    }
//
//    group.notify(queue: .main) {
//        self.dataTuple = (
//            episode,
//            characters
//        )
//    }
//}
