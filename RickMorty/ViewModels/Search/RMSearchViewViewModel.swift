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
final class RMSearchViewViewModel {
    let config: RMSearchViewController.Config
    
    private var optionMapUpdateBlock: (((RMSearchBarViewViewModel.DynamicOption, String)) -> Void)?
    private var optionMap: [RMSearchBarViewViewModel.DynamicOption: String] = [:]
    
    // MARK: - Init
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    // MARK: - Public
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
