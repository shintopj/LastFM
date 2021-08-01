//
//  BaseTableViewCell.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//


import UIKit

class BaseTableViewCell<V>: UITableViewCell {
    open var item: V!
}

extension BaseTableViewCell: NibLoadableTableViewCell, ReusableTableViewCell { }
