//
//  AlbumListConfigurator.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import Foundation

struct AlbumListConfigurator {
    static func create() -> AlbumListViewController {
        let viewController: AlbumListViewController = .viewController()
        let presenter = AlbumListPresenter(viewController: viewController)
        let worker = AlbumListWorker()
        let interactor = AlbumListInteractor(presenter: presenter, worker: worker)
        let router = AlbumListRouter(viewController: viewController, dataStore: interactor)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
