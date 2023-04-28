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

    public func set(query text: String) {
        self.searchText = text
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
}

