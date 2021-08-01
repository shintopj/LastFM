//
//  UIState.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import UIKit

enum Status {
    case error, noError, noNetwork, noData, loading
}

class UIState {
    var status: Status = .loading
    var message: String = Strings.loading
    var image: UIImage? = UIImage.loading
    
    init(status: Status, message: String = Strings.loading) {
        self.status = status
        self.message = message
    }
    
    init(status: Status, message: String, image: UIImage) {
        self.status = status
        self.message = message
        self.image = image
    }
    
    func update(status: Status, message: String? = nil) {
        self.status = status
        if status == .loading {
            self.image = UIImage.loading
            self.message = message ?? Strings.loading
        } else if status == .noNetwork {
            self.image = UIImage.noNetwork
            self.message = message ?? Strings.noNetwork
        } else if status == .error {
            self.image = UIImage.error
            self.message = message ?? Strings.applicationError
        } else {
            self.image = UIImage.noData
            self.message = message ?? Strings.noData
        }
    }
}
