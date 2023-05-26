//
//  RMSearchResultsType.swift
//  RickMorty
//
//  Created by Brian on 01/05/2023.
//

import Foundation

final class RMSearchResultsviewModel {
    let results: RMSearchResultsType
    private var next: String?
    
    init(results: RMSearchResultsType, next: String?) {
        self.results = results
        self.next = next
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return next != nil
    }
    
    public private(set) var isLoadingMoreResults = false
    
    public func fetchAdditionalLocations() {
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
//                strongSelf.cellViewModels.append(contentsOf: moreResults.compactMap({
//                    return RMLocationTableViewCellViewModel(location: $0)
//                }))
                DispatchQueue.main.async {
                    strongSelf.isLoadingMoreResults = false
                    
//                    // Notify
//                    strongSelf.didFinishPagination?()
                }
            
               
            case .failure(let err):
                strongSelf.isLoadingMoreResults = false
                print("We failed to get the response \(err)")
            }
        }
    }
}

enum RMSearchResultsType {
    case characters([RMCharacterCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
    case episodes([RMCharacterEpisodeViewCellViewModel])
}
