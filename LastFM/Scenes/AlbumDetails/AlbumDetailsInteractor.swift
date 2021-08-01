//
//  AlbumDetailsInteractor.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import UIKit

protocol AlbumDetailsBusinessLogic: AnyObject {
    func getDetails()
}

protocol AlbumDetailsDataStore: AnyObject {
    var album: AlbumViewModel? { get set }
    var albumDetails: AlbumDetails? { get }
}

final class AlbumDetailsInteractor: AlbumDetailsDataStore {

    private let presenter: AlbumDetailsPresentationLogic
    private let worker: AlbumDetailsWorkerProtocol
    var album: AlbumViewModel?
    var albumDetails: AlbumDetails?
    
    init(presenter: AlbumDetailsPresentationLogic, worker: AlbumDetailsWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
}

// MARK: - BusinessLogic
extension AlbumDetailsInteractor: AlbumDetailsBusinessLogic {

    func getDetails() {
        
        if let album = album {
            presenter.present(album: album)
        }
        
        if albumDetails == nil, let name = album?.name, let artist = album?.artist {
            
            worker.details(album: name, artist: artist) { [weak self] result in
        
                switch result {
                case let .success(result):
                    
                    if result.error != nil, let message = result.message {
                        self?.presenter.present(error: NSError(domain: "error", code: 1, userInfo: [NSLocalizedDescriptionKey: message]))
                    } else {
                        self?.presenter.present(album: result)
                    }
                    
                case let .failure(error):
                    self?.presenter.present(error: error)
                }
            }
        }
    }
}
