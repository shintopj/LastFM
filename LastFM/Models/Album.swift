//
//  Album.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import UIKit

// MARK: - Album
struct Album: Codable {
    let name: String?
    let artist: String?
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

struct AlbumViewModel: Hashable, Identifiable {
    let name: String?
    let artist: String?
    let url: String?
    let imageURL: String?
    
    let id = UUID()
    
    init(album: Album) {
        name = album.name
        artist = album.artist
        url = album.url
        
        if let mediumURL = album.image?.first(where: { $0.size == "medium" })?.text {
            imageURL = mediumURL
        } else if let largeURL = album.image?.first(where: { $0.size == "medium" })?.text {
            imageURL = largeURL
        } else if !(album.image?.isEmpty ?? true) {
            imageURL = album.image?[0].text
        } else {
            imageURL = ""
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(artist)
    }
    
    static func == (lhs: AlbumViewModel, rhs: AlbumViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
