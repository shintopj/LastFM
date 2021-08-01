//
//  NoContentToDisplayView.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import UIKit

class NoContentToDisplayView: UIView {
    
    let imageView = UIImageView()
    let label = UILabel()
    let spinner = UIActivityIndicatorView()
    
    var state: UIState? {
        didSet {
            label.text = state?.message ?? Strings.noData
            imageView.image = state?.image
            
            if state?.status == .loading {
                spinner.startAnimating()
            } else {
                spinner.stopAnimating()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondary
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .secondaryText
        
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.textColor = .primaryText
        label.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [imageView, spinner, label])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        
        spinner.tintColor = .primaryText
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Auto layout
        NSLayoutConstraint.activate(
            [
                stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 160),
                imageView.widthAnchor.constraint(equalToConstant: 220)
            ]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
