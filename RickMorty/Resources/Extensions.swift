//
//  Extensions.swift
//  RickMorty
//
//  Created by Brian on 20/03/2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ view in
            self.addSubview(view)
        })
    }
}

extension UIDevice {
    /// Check if current device is phone idiom
    static let isiPhone = UIDevice.current.userInterfaceIdiom == .phone
}
