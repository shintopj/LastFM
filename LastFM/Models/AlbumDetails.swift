//
//  AlbumDetails.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import Foundation

// MARK: - AlbumDetails
struct AlbumDetails: Codable {
    let album: AlbumMeta?
    let error: String?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case album
        case error
        case message
    }
}

// MARK: - Album
struct AlbumMeta: Codable {
    let listeners: String?
    let playcount: String?
    let wiki: Wiki?
    let tracks: Tracks?
    let image: [Image]?
    let tags: Tags?
    let url: String?
    let artist: String?
    let name: String?
    let mbid: String?
    
    enum CodingKeys: String, CodingKey {
        case listeners
        case playcount
        case wiki
        case tracks
        case image
        case tags
        case url
        case artist
        case name
        case mbid
    }
}

// MARK: - Tags
struct Tags: Codable {
    let tag: [Tag]?
    
    enum CodingKeys: String, CodingKey {
        case tag
    }
}

// MARK: - Tag
struct Tag: Codable {
    let name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

// MARK: - Tracks
struct Tracks: Codable {
    let track: [Track]?
    
    enum CodingKeys: String, CodingKey {
        case track
    }
}

// MARK: - Wiki
struct Wiki: Codable {
    let published: String?
    let content: String?
    let summary: String?
    
    enum CodingKeys: String, CodingKey {
        case published
        case content
        case summary
    }
}
