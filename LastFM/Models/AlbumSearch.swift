//
//  Album.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import Foundation

// MARK: - AlbumSearch
struct AlbumSearch: Codable {
    let results: Results?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Results
struct Results: Codable {
    let opensearchQuery: OpensearchQuery?
    let opensearchTotalResults: String?
    let opensearchStartIndex: String?
    let opensearchItemsPerPage: String?
    let albummatches: Albummatches?
    let attr: Attr?
    
    enum CodingKeys: String, CodingKey {
        case opensearchQuery = "opensearch:Query"
        case opensearchTotalResults = "opensearch:totalResults"
        case opensearchStartIndex = "opensearch:startIndex"
        case opensearchItemsPerPage = "opensearch:itemsPerPage"
        case albummatches
        case attr = "@attr"
    }
}

// MARK: - Albummatches
struct Albummatches: Codable {
    let album: [Album]?
    
    enum CodingKeys: String, CodingKey {
        case album
    }
}

// MARK: - Attr
struct Attr: Codable {
    let attrFor: String?
    
    enum CodingKeys: String, CodingKey {
        case attrFor = "for"
    }
}

// MARK: - OpensearchQuery
struct OpensearchQuery: Codable {
    let text: String?
    let role: String?
    let searchTerms: String?
    let startPage: String?
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case role
        case searchTerms
        case startPage
    }
}
