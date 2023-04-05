//
//  RMEpisodeDetailViewViewModel.swift
//  RickMorty
//
//  Created by Brian on 05/04/2023.
//

import UIKit

final class RMEpisodeDetailViewViewModel: NSObject {
    private let episodeURL: URL?
    init(url: URL?) {
        self.episodeURL = url
    }
    
    public func fetchEpisodeData() {
        guard let url = episodeURL, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
