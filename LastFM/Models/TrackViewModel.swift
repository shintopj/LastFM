//
//  TrackViewModel.swift
//  LastFM
//
//  Created by Shinto Joseph on 01/08/2021.
//

import Foundation

struct TrackViewModel {
    let title: String
    let details: String
    
    init(item: Track) {
        title = item.name
        details = "Artist: \(item.artist?.name ?? Strings.empty), length: \(TrackViewModel.getDuration(item: item.duration))"
    }
    
    private static func getDuration(item: Int?) -> String {
        let minutes = (item ?? 0) / 60
        let seconds = (item ?? 0) % 60
        
        return "\(minutes):\(seconds)"
    }
}
