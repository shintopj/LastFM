//
//  AlbumDetailsConfigurator.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import Foundation

struct AlbumDetailsConfigurator {
    
    static func create() -> AlbumDetailsViewController {
        let viewController: AlbumDetailsViewController = .viewController()
        let presenter = AlbumDetailsPresenter(viewController: viewController)
        let worker = AlbumDetailsWorker()
        let interactor = AlbumDetailsInteractor(presenter: presenter, worker: worker)
        let router = AlbumDetailsRouter(viewController: viewController, dataStore: interactor)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
