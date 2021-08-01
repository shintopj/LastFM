//
//  Album.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import UIKit

// MARK: - Album
struct Album: Codable {
    let name: String
    let artist: String
    let url: String?
    let image: [Image]?
    let streamable: String?
    let mbid: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case artist
        case url
        case image
        case streamable
        case mbid
    }
}
