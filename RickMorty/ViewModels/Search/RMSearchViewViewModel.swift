//
//  RMSearchViewViewModel\.swift
//  RickMorty
//
//  Created by Brian on 18/04/2023.
//

import Foundation

// Show search results
// No results view
// Kick off API request
//final class RMSearchViewViewModel {
//    let config: RMSearchViewController.Config
//
//    private var optionMap: [RMSearchBarViewViewModel.DynamicOption: String] = [:]
//    private var optionMapUpdateBlock: (((RMSearchBarViewViewModel.DynamicOption, String)) -> Void)?
//
//
//    // MARK: - Init
//    init(config: RMSearchViewController.Config) {
//        self.config = config
//    }
//
//    // MARK: - Public
//    public func set(value: String, for option: RMSearchBarViewViewModel.DynamicOption) {
//        optionMap[option] = value
//        let tuple = (option, value)
//        print("We have an update \(tuple)")
//        optionMapUpdateBlock?(tuple)
//    }
//
//    public func registerOptionChangeBlock(
//        _ block: @escaping ((RMSearchBarViewViewModel.DynamicOption, String)) -> Void
//       ) {
//           print("We were init")
//           self.optionMapUpdateBlock = block
//       }
//}

final class RMSearchViewViewModel {
    let config: RMSearchViewController.Config
    private var optionMap: [RMSearchBarViewViewModel.DynamicOption: String] = [:]
    
    private var searchText = ""

    private var optionMapUpdateBlock: (((RMSearchBarViewViewModel.DynamicOption, String)) -> Void)?
    
    private var noResultsHandler: (() -> Void)?

    private var searchResultModel: Codable?
    
    private var searchResultsHandler: ((RMSearchResultsViewModel) -> Void)?

    // MARK: - Init

    init(config: RMSearchViewController.Config) {
        self.config = config
    }

    // MARK: - Public

    public func registerNoResultsHandler(_ block: @escaping () -> Void) {
        self.noResultsHandler = block
    }

    private func handleNoResults() {
        noResultsHandler?()
    }
    
    public func set(value: String, for option: RMSearchBarViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }

    public func registerOptionChangeBlock(
        _ block: @escaping ((RMSearchBarViewViewModel.DynamicOption, String)) -> Void
    ) {
        self.optionMapUpdateBlock = block
    }
    
    public func registerSearchResultsHandler(_ block: @escaping (RMSearchResultsViewModel) -> Void) {
        self.searchResultsHandler = block
    }
    
    public func executeSearch() {
        // Create Request based on filter
        var queryParams: [URLQueryItem] = [
            URLQueryItem(
                name: "name",
                value: searchText.addingPercentEncoding(
                    withAllowedCharacters: .urlQueryAllowed
                )
            )
        ]
    
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key: RMSearchBarViewViewModel.DynamicOption = element.key
            let value: String = element.value
            
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
        // Send API Call
        let request = RMRequest(
            endpoint: config.type.endpoint,
            queryParameters: queryParams
        )
        switch config.type.endpoint {
        case .character:
            makeAPICall(RMGetAllCharactersResponse.self, request: request)
        case .episode:
            makeAPICall(RMGetAllEpisodesResponse.self, request: request)
        case .location:
            makeAPICall(RMGetLocationsResponse.self, request: request)
        }
        
        // Notify View of results, or no results.
    }
    
    private func makeAPICall<T: Codable>(_ type: T.Type, request: RMRequest) {
        RMService.shared.execute(request, expecting: type) { [weak self] result in
            switch result {
            case .success(let model):
                self?.processSearchResults(model)
            case .failure:
                self?.handleNoResults()
                break
            }
        }
    }
    
    private func processSearchResults(_ model: Codable) {
        var resultsVM: RMSearchResultsViewModel?
        if let characterResults = model as? RMGetAllCharactersResponse {
            resultsVM = .characters(characterResults.results.compactMap({ character in
                return RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterURL: URL(string: character.image)
                )
            }))
        } else if let episodesResults = model as? RMGetAllEpisodesResponse {
            print("We have some episode data")
            resultsVM = .episodes(episodesResults.results.compactMap({ episode in
                return RMCharacterEpisodeViewCellViewModel(episodeDataUrl: URL(string: episode.url ))
            }))
        } else if let locationResults = model as? RMGetLocationsResponse {
            resultsVM = .locations(locationResults.results.compactMap({ location in
                return RMLocationTableViewCellViewModel(location: location)
            }))
        }
        
        if let results = resultsVM {
            self.searchResultModel = model
            self.searchResultsHandler?(results)
        } else {
            // Fallback error
            handleNoResults()
        }
    }
    
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func locationSearchResult(at index: Int) -> RMLocation? {
        guard let searchModel = searchResultModel as? RMGetLocationsResponse else {
            return nil
        }
        return searchModel.results[index]
    }
    
    public func episodeSearchResult(at index: Int) -> RMEpisode? {
        guard let searchModel = searchResultModel as? RMGetAllEpisodesResponse else {
            return nil
        }
        return searchModel.results[index]
    }
    
    public func characterSearchResult(at index: Int) -> RMCharacter? {
        guard let searchModel = searchResultModel as? RMGetAllCharactersResponse else {
            return nil
        }
        return searchModel.results[index]
    }
}

