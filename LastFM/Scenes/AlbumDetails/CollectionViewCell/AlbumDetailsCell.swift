//
//  AlbumDetailsCell.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import SDWebImage
import UIKit

class AlbumDetailsCell: BaseCollectionViewCell<AlbumViewModel> {

    @IBOutlet private weak var imgIcon: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var item: AlbumViewModel? {
        didSet {
            lblTitle.text = item?.name
            lblDescription.text = item?.artist
            
            if let imageURL = item?.imageURL {
                self.imgIcon?.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage.placeholder)
            }   
        }
    }
}
