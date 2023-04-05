//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickMorty
//
//  Created by Brian on 31/03/2023.
//

import Foundation


protocol RMEpisodeDataRender {
    var episode: String { get }
    var name: String { get }
    var air_date: String { get }
}

final class RMCharacterEpisodeViewCellViewModel {
    private let episodeDataUrl: URL?
    private var isFetching: Bool = false
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    // MARK: - Init
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    
    
    // MARK: - Public
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        guard let url = episodeDataUrl, let rmRequest = RMRequest(url: url) else {
            return
        }
       
        isFetching = true
        RMService.shared.execute(rmRequest, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
