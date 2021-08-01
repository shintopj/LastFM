//
//  ReusableCollectionViewCell.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import UIKit

public protocol ReusableCollectionViewCell: AnyObject {
    static var reuseIdentifier: String { get }
}

//typealias Live = UICollectionViewCell & UICollectionReusableView

extension ReusableCollectionViewCell where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
