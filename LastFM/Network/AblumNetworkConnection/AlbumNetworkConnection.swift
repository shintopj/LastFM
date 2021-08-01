//
//  AlbumNetworkConnection.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import Combine
import LastFMNetwork

protocol AlbumNetworkConnectionProtocol: AnyObject {
    var networkController: NetworkControllerProtocol { get }
    
    func searchAlbum(query: String) -> AnyPublisher<AlbumSearch, Error>
    func getAlbumDetails(album: String, artist: String) -> AnyPublisher<AlbumDetails, Error>
}

final class AlbumNetworkConnection: AlbumNetworkConnectionProtocol {
    
    let networkController: NetworkControllerProtocol
    
    init(networkController: NetworkControllerProtocol) {
        self.networkController = networkController
    }
    
    func searchAlbum(query: String) -> AnyPublisher<AlbumSearch, Error> {
        let headers: [String: String] = [:]
        var parameters: [String: String] = [:]
        
        parameters["method"] = "album.search"
        parameters["album"] = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        parameters["api_key"] = NetworkConfig.apiKey
        parameters["format"] = "json"
        
        let request = NetworkRequest.get(url: Urls.Album.search, parameters: parameters, headers: headers)
        return networkController.get(request: request)
    }
    
    func getAlbumDetails(album: String, artist: String) -> AnyPublisher<AlbumDetails, Error> {
        let headers: [String: String] = [:]
        var parameters: [String: String] = [:]
        
        parameters["method"] = "album.getinfo"
        parameters["album"] = album
        parameters["artist"] = artist
        parameters["api_key"] = NetworkConfig.apiKey
        parameters["format"] = "json"
        
        let request = NetworkRequest.get(url: Urls.Album.details, parameters: parameters, headers: headers)
        return networkController.get(request: request)
    }
}
