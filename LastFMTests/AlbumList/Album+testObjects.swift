//
//  Album+testObjects.swift
//  LastFMTests
//
//  Created by Shinto Joseph on 01/08/2021.
//

import Foundation
@testable import LastFM

extension Album {
    static var testObjects: [Album] {
        return [
            Album(name: "Test Ablum Name 1", artist: "Test Artist 1", url: "https://last.fm", image: nil, streamable: "", mbid: "#239"),
            Album(name: "Test Ablum Name 2", artist: "Test Artist 2", url: "https://last.fm", image: nil, streamable: "", mbid: "#249")
        ]
    }
}
