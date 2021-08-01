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
            label.text = self.state?.message ?? Strings.noData
            imageView.image = self.state?.image
            
            if state?.status == .loading {
                spinner.startAnimating()
            } else {
                spinner.stopAnimating()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .secondary
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .primaryText
        
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
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Auto layout
        NSLayoutConstraint.activate(
            [
                stackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 32),
                stackView.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -32),
                stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 200),
                imageView.widthAnchor.constraint(equalToConstant: 240),
                spinner.heightAnchor.constraint(equalToConstant: 30),
                spinner.widthAnchor.constraint(equalToConstant: 120)
            ]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
