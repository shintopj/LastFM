//
//  Track.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import Foundation

// MARK: - Track
struct Track: Codable {
    let name: String
    let artist: Artist?
    let attr: Attr?
    let duration: Int?
    let url: String?
    let streamable: Streamable?
    
    enum CodingKeys: String, CodingKey {
        case artist
        case attr = "@attr"
        case duration
        case url
        case name
        case streamable
    }
}

// MARK: - Artist
struct Artist: Codable {
    let name: String
    let url: String?
    let mbid: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case name
        case mbid
    }
}

// MARK: - Streamable
struct Streamable: Codable {
    let fulltrack: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case fulltrack
        case text = "#text"
    }
}
