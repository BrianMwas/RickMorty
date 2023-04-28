//
//  RMSearchView.swift
//  RickMorty
//
//  Created by Brian on 18/04/2023.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchBarViewViewModel.DynamicOption)
}

//final class RMSearchView: UIView {
//
//    weak var delegate: RMSearchViewDelegate?
//    private let viewModel: RMSearchViewViewModel
//
//
//    // MARK: - Subviews
//
//    // Search bar, selection
//    private let inputBarView = RMSearchBarView()
//
//    // No results views
//    private let noResultsView = RMNoSearchResultsView()
//
//    // Results collection view
//
//    // MARK: - Init
//    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
//        self.viewModel = viewModel
//        super.init(frame: frame)
//        backgroundColor = .systemBackground
//        translatesAutoresizingMaskIntoConstraints = false
//        addSubviews(noResultsView, inputBarView)
//        addConstraints()
//
//        inputBarView.configure(with: RMSearchBarViewViewModel(type: viewModel.config.type))
//        inputBarView.delegate = self
//
//        viewModel.registerOptionChangeBlock { tuple in
//            print("Some quick tuple")
//            self.inputBarView.update(option: tuple.0, value: tuple.1)
//        }
//    }
//
//    required init?(coder: NSCoder?) {
//        fatalError()
//    }
//
//    private func addConstraints() {
//        NSLayoutConstraint.activate([
//            // Search view
//            inputBarView.topAnchor.constraint(equalTo: topAnchor),
//            inputBarView.leftAnchor.constraint(equalTo: leftAnchor),
//            inputBarView.rightAnchor.constraint(equalTo: rightAnchor),
//            inputBarView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 : 110),
//
//            // No results view
//            noResultsView.heightAnchor.constraint(equalToConstant: 150),
//            noResultsView.widthAnchor.constraint(equalToConstant: 150),
//            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
//        ])
//    }
//
//    public func presentKeyboard() {
//        inputBarView.presentKeyboard()
//    }
//}
//
//// MARK: - CollectionView
//extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//
//    }
//}


// MARK: - RMSearchBarViewDelegate
extension RMSearchView: RMSearchBarViewDelegate {
    func rmSearchInputView(
        _ inputView: RMSearchBarView,
        didSelectOption option: RMSearchBarViewViewModel.DynamicOption
    ) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
}

final class RMSearchView: UIView {

    weak var delegate: RMSearchViewDelegate?

    private let viewModel: RMSearchViewViewModel

    // MARK: - Subviews

    private let searchInputView = RMSearchBarView()

    private let noResultsView = RMNoSearchResultsView()

//    private let resultsView = RMSearchResultsView()

    // Results collectionView

    // MARK: - Init

    init(frame: CGRect, vm: RMSearchViewViewModel) {
        self.viewModel = vm
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultsView, searchInputView)
        addConstraints()

        searchInputView.configure(with: RMSearchBarViewViewModel(type: viewModel.config.type))
        searchInputView.delegate = self

        vm.registerOptionChangeBlock { tuple in
            print("We have an update tuple \(tuple)")
            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }


    private func addConstraints() {
        NSLayoutConstraint.activate([
            // Search input view
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 : 110),

            // No results
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    public func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
}

// MARK: - CollectionView

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)


    }
}

