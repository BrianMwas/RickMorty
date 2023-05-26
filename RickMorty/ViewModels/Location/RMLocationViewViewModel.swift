//
//  RMLocationViewViewModel.swift
//  RickMorty
//
//  Created by Brian on 15/04/2023.
//

import Foundation

protocol RMLocationViewViewDelegate: AnyObject {
    func didFetchInitialLocations()
    func didLoadMoreLocations(with newIndexPaths: [IndexPath])
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
    
    private var isLoadingMoreLocations: Bool = false
    
    private var didFinishPagination: (() -> Void)?
    
    public func registerDidFinishPaginationBlock(_ block: @escaping () -> Void) {
        self.didFinishPagination = block
    }
    
    // Location response info
    // Will contain next URL if present
    private var apiInfo: RMGetLocationsResponse.Info?
    
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel]  = []
    
    public func location(at index: Int) -> RMLocation? {
        guard index < self.locations.count, index >= 0 else {
            return nil
        }
        print("We got the location at \(index)")
        return self.locations[index]
    }
    
    // MARK: - Init
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
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    public func fetchAdditionalLocations() {
        guard !isLoadingMoreLocations else {
            return
        }
        // Fetch episodes here
        isLoadingMoreLocations = true
        
        guard let nextUrlString = apiInfo?.next,
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
                strongSelf.apiInfo = info
                strongSelf.cellViewModels.append(contentsOf: moreResults.compactMap({
                    return RMLocationTableViewCellViewModel(location: $0)
                }))
                DispatchQueue.main.async {
                    strongSelf.isLoadingMoreLocations = false
                    
                    // Notify 
                    strongSelf.didFinishPagination?()
                }
            
               
            case .failure(let err):
                strongSelf.isLoadingMoreLocations = false
                print("We failed to get the response \(err)")
            }
        }
    }
}
