//
//  Image.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import Foundation

// MARK: - Image
struct Image: Codable {
    let text: String?
    let size: String?
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size = "size"
    }
}
