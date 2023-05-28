//
//  RMSearchResultsType.swift
//  RickMorty
//
//  Created by Brian on 01/05/2023.
//

import Foundation

final class RMSearchResultsviewModel {
    public private(set) var results: RMSearchResultsType
    private var next: String?
    
    init(results: RMSearchResultsType, next: String?) {
        self.results = results
        self.next = next
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return next != nil
    }
    
    public private(set) var isLoadingMoreResults = false
    
    public func fetchAdditionalLocations(
        completion: @escaping ([RMLocationTableViewCellViewModel]) -> Void
    ) {
        guard !isLoadingMoreResults else {
            return
        }
        
        // Fetch episodes here
        isLoadingMoreResults = true
        
        guard let nextUrlString = next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        guard let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetLocationsResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let success):
                let moreResults = success.results
                let info = success.info
                strongSelf.next = info.next
                let additionalLocations = moreResults.compactMap({
                    return RMLocationTableViewCellViewModel(location: $0)
                })
                var newResults :[RMLocationTableViewCellViewModel] = []
                switch strongSelf.results {
                case .locations(let existingLocations):
                    newResults = existingLocations + additionalLocations
                    strongSelf.results = .locations(newResults)
                    break
                case .characters, .episodes:
                    break
                }
                DispatchQueue.main.async {
                    strongSelf.isLoadingMoreResults = false
                    
                    // Notify the UI of the new changes
                    completion(newResults)
                }
            
               
            case .failure(let err):
                strongSelf.isLoadingMoreResults = false
                print("We failed to get the response \(err)")
            }
        }
    }
    
    public func fetchAdditionalResults(
        completion: @escaping ([any Hashable]) -> Void
    ) {
        guard !isLoadingMoreResults else {
            return
        }
        
        // Fetch episodes here
        isLoadingMoreResults = true
        
        guard let nextUrlString = next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        guard let request = RMRequest(url: url) else {
            return
        }
        
        switch results {
        case .characters(let existingResults):
            RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.next = info.next
                    let additionalCharacters = moreResults.compactMap({
                        return RMCharacterCollectionViewCellViewModel(
                            characterName: $0.name,
                            characterStatus: $0.status,
                            characterURL: URL(string: $0.url)
                        )
                    })
                    var newResults = existingResults + additionalCharacters
                    strongSelf.results = .characters(newResults)
                    DispatchQueue.main.async {
                        strongSelf.isLoadingMoreResults = false
                        
                        // Notify the UI of the new changes
                        completion(newResults)
                    }
                
                   
                case .failure(let err):
                    strongSelf.isLoadingMoreResults = false
                    print("We failed to get the response \(err)")
                }
            }
        case .episodes(let existingEpisodes):
            RMService.shared.execute(request, expecting: RMGetAllEpisodesResponse.self) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.next = info.next
                    let additionalEpisodes = moreResults.compactMap({
                        return RMCharacterEpisodeViewCellViewModel(episodeDataUrl: URL(string: $0.url))
                    })
                    var newResults = existingEpisodes + additionalEpisodes
                    strongSelf.results = .episodes(newResults)
                    DispatchQueue.main.async {
                        strongSelf.isLoadingMoreResults = false
                        
                        // Notify the UI of the new changes
                        completion(newResults)
                    }
                
                   
                case .failure(let err):
                    strongSelf.isLoadingMoreResults = false
                    print("We failed to get the response \(err)")
                }
            }
        case .locations:
            // Table view case
            break
        }
    }
}



enum RMSearchResultsType {
    case characters([RMCharacterCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
    case episodes([RMCharacterEpisodeViewCellViewModel])
}
