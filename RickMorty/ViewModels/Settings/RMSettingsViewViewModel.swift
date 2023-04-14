//
//  SettingsViewViewModel.swift
//  RickMorty
//
//  Created by Brian on 14/04/2023.
//

import Foundation


struct RMSettingsViewViewModel {
    public let cellViewModels: [RMSettingsCellViewModel]
    
    // MARK: - Init
    init(cellViewModels: [RMSettingsCellViewModel]) {
        self.cellViewModels = cellViewModels
    }
}
