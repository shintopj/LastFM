//
//  SectionHeaderReusableView.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
    @IBOutlet private weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var item: String? {
        didSet {
            lblTitle.text = item
        }
    }
}
