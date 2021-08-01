//
//  AlbumListInteractor.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import Combine
import UIKit

protocol AlbumListBusinessLogic: AnyObject {
    func fetch(query: String)
}

protocol AlbumListDataStore: AnyObject {
    var albums: [Album] { get }
}

final class AlbumListInteractor: AlbumListDataStore {
    
    var albums = [Album]()
    
    private let presenter: AlbumListPresentationLogic
    private let worker: AlbumListWorkerProtocol

    init(presenter: AlbumListPresentationLogic, worker: AlbumListWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
}

// MARK: - BusinessLogic
extension AlbumListInteractor: AlbumListBusinessLogic {
    
    func fetch(query: String) {
        worker.search(query: query) { [weak self] result in
            
            switch result {
            case let .success(result):
                
                if let albums = result.results?.albummatches?.album {
                    self?.albums = albums
                    self?.presenter.present(albums: albums)
                }
                
            case let .failure(error):
                self?.presenter.present(error: error)
            }
        }
    }
}
