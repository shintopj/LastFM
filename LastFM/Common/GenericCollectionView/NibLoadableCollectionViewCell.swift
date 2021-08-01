//
//  NibLoadableCollectionViewCell.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import UIKit

public protocol NibLoadableCollectionViewCell: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableCollectionViewCell where Self: UICollectionViewCell {
    public static var nibName: String {
        return String(describing: self)
    }
}
