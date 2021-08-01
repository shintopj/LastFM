//
//  AlbumDetailsWorker.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import Combine
import LastFMNetwork
import UIKit

protocol AlbumDetailsWorkerProtocol: AnyObject {
    func details(album: String, artist: String, completion: @escaping (Result<AlbumDetails, Error>) -> Void)
}

final class AlbumDetailsWorker: AlbumDetailsWorkerProtocol {
    
    var cancellable: AnyCancellable?
    
    func details(album: String, artist: String, completion: @escaping (Result<AlbumDetails, Error>) -> Void) {
        
        cancellable = AlbumNetworkConnection(networkController: NetworkController())
            .getAlbumDetails(album: album, artist: artist)
            .mapError { error -> Error in
                return error
            }
            .sink(
                receiveCompletion: { _ in
                    print(#function, "receive getAlbumDetails Completion")
                },
                receiveValue: { response in
                    completion(.success(response))
                }
            )
    }
}
