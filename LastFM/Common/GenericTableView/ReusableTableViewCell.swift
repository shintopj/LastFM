//
//  ReusableTableViewCell.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import UIKit

public protocol ReusableTableViewCell: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableTableViewCell where Self: UITableViewCell {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
