//
//  NibLoadableTableViewCell.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import UIKit

public protocol NibLoadableTableViewCell: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableTableViewCell where Self: UITableViewCell {
    static var nibName: String {
        return String(describing: self)
    }
}
