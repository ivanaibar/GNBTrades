//
//  UITableView+Cell.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 04/11/2020.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    
    /// TIP: you must set the reuse identifier as same as the nib file name.
    func register<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }
}
