//
//  Track.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import Foundation

// MARK: - Track
struct Track: Codable {
    let artist: Artist?
    let attr: Attr?
    let duration: Int?
    let url: String?
    let name: String?
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
    let url: String?
    let name: String?
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

struct TrackViewModel {
    let title: String
    let details: String
    
    init(item: Track) {
        title = item.name ?? Strings.empty
        details = "Artist: \(item.artist?.name ?? Strings.empty), length: \(TrackViewModel.getDuration(item: item.duration))"
    }
    
    private static func getDuration(item: Int?) -> String {
        let minutes = (item ?? 0) / 60
        let seconds = (item ?? 0) % 60
        
        return "\(minutes):\(seconds)"
    }
}
