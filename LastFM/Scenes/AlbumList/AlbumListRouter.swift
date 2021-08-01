//
//  AlbumListRouter.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import UIKit

protocol AlbumListRoutingLogic: AnyObject {
    func routeToNext(item: AlbumViewModel)
}

protocol AlbumListDataPassing: AnyObject {
    var dataStore: AlbumListDataStore? { get }
}

final class AlbumListRouter: AlbumListDataPassing {

    private weak var viewController: AlbumListViewController?
    private(set) weak var dataStore: AlbumListDataStore?
    
    init(viewController: AlbumListViewController?, dataStore: AlbumListDataStore?) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    func passDataToDetails(item: AlbumViewModel, destination: inout AlbumDetailsDataStore) {
        destination.album = item
    }
}

// MARK: - RoutingLogic

extension AlbumListRouter: AlbumListRoutingLogic {
    func routeToNext(item: AlbumViewModel) {
        //guard let dataStore = dataStore else { return }
        
        let destinationViewController = AlbumDetailsConfigurator.create()
        if var destinationDS = destinationViewController.router?.dataStore {
            passDataToDetails(item: item, destination: &destinationDS)
        }
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
