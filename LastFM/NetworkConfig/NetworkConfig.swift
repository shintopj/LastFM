//
//  NetworkConfig.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import Foundation

// MARK: - Network environment
enum NetworkEnvironment {
    case development
    case production
}

var environment: NetworkEnvironment {
    #if DEBUG
    return .development
    #else
    return .production
    #endif
}

// MARK: - BaseURL API
private var environmentAPIBaseURL: String {
    switch environment {
    case .production:
        return "https://ws.audioscrobbler.com"
    case .development:
        return "https://ws.audioscrobbler.com"
    }
}

var apiURL: (String) -> URL = { path in
    guard let url = URL(string: environmentAPIBaseURL.appending(path)) else { fatalError("baseURL could not be configured.") }
    return url
}

// MARK: - Api key configs
enum NetworkConfig {

    // MARK: - api key for each environment
    static var apiKey: String {
        switch environment {
        case .production:
            return "e9c2c92725801ca7c962d966ff188f92"
        case .development:
            return "e9c2c92725801ca7c962d966ff188f92"
        }
    }
    
}
