//
//  AlbumListCell.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import SDWebImage
import UIKit

class AlbumListCell: BaseTableViewCell<AlbumViewModel> {

    @IBOutlet private weak var imgIcon: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var item: AlbumViewModel? {
        didSet {
            
            if let title = item?.name {
                self.lblTitle?.text = title
            }
            
            if let body = item?.artist {
                self.lblDescription?.text = body
            }
            
            if let imageURL = item?.imageURL {
                self.imgIcon?.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage.placeholder)
            }
        }
    }
}
