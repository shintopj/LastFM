//
//  Urls.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import Foundation

enum Urls {
    
    enum Album {
        /// search ablum by name
        static var search: URL {
            return apiURL("/2.0")
        }
        
        static var details: URL {
            return apiURL("/2.0")
        }
    }
}
