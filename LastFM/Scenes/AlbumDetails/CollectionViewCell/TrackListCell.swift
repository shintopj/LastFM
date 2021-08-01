//
//  TrackListCell.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import UIKit

class TrackListCell: BaseCollectionViewCell<TrackViewModel> {
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var item: TrackViewModel? {
        didSet {
            lblTitle.text = item?.title
            lblDetails.text = item?.details
        }
    }
}
