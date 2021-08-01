//
//  BaseCollectionViewCell.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import UIKit

class BaseCollectionViewCell<V>: UICollectionViewCell {
    open var item: V!
}

extension BaseCollectionViewCell: NibLoadableCollectionViewCell, ReusableCollectionViewCell { }
