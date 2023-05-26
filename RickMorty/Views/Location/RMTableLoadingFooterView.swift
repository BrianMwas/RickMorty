//
//  RMTableLoadingFooterView.swift
//  RickMorty
//
//  Created by Brian on 25/05/2023.
//

import UIKit

final class RMTableLoadingFooterView: UIView {
    // This is an anonymous closure
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        spinner.startAnimating()
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 55),
            spinner.heightAnchor.constraint(equalToConstant: 55),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
//            self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
//            self.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
