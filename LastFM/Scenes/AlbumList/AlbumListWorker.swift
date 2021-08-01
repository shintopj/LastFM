//
//  AlbumListWorker.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import Combine
import LastFMNetwork
import UIKit

protocol AlbumListWorkerProtocol: AnyObject {
    func search(query: String, completion: @escaping (Result<AlbumSearch, Error>) -> Void)
}

final class AlbumListWorker: AlbumListWorkerProtocol {

    var cancellable: AnyCancellable?
    
    func search(query: String, completion: @escaping (Result<AlbumSearch, Error>) -> Void) {
        cancellable = AlbumNetworkConnection(networkController: NetworkController())
            .searchAlbum(query: query)
            .mapError { error -> Error in
                completion(.failure(error))
                return error
            }
            .sink(
                receiveCompletion: { _ in
                    print(#function, "receive searchAlbum Completion")
                },
                receiveValue: { response in
                    completion(.success(response))
                }
            )
        
    }
}
