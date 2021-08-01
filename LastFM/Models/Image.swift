//
//  Image.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import Foundation

// MARK: - Image
struct Image: Codable {
    var text: String?
    var size: String?
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size = "size"
    }
}
