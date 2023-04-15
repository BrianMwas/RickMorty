//
//  RMLocationViewViewModel.swift
//  RickMorty
//
//  Created by Brian on 15/04/2023.
//

import Foundation

protocol RMLocationViewViewDelegate: AnyObject {
    func didFetchInitialLocations()
}

final class RMLocationViewViewModel {
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    weak var delegate: RMLocationViewViewDelegate?
    
    // Location response info
    // Will contain next URL if present
    private var apiInfo: RMGetLocationsResponse.Info?
    
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel]  = []
    
    init() {
        
    }
    
    public func fetchLocations() {
        print("We fetched locations")
        RMService.shared.execute(
            .listLocationsRequest,
            expecting: RMGetLocationsResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
               
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure(let failure):
                print("We failed to get locations \(failure)")
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
