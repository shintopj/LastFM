//
//  UIImage+Extensions.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import UIKit

extension UIImage {
    
    // Loading screen
    static var loading: UIImage? {
        return UIImage(systemName: "waveform")
    }
    
    static var noData: UIImage? {
        return UIImage(systemName: "tray")
    }
    
    static var noNetwork: UIImage? {
        return UIImage(systemName: "wifi.slash")
    }
    
    static var error: UIImage? {
        return UIImage(systemName: "exclamationmark.triangle")
    }
    
    // Search
    static var search: UIImage? {
        return UIImage(systemName: "search")
    }
    
    static var clear: UIImage? {
        return UIImage(systemName: "xmark.circle.fill")
    }
    
    static var placeholder: UIImage? {
        return UIImage(systemName: "photo")
    }
}
