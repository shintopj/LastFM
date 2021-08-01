//
//  AlbumDetailsRouter.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import UIKit

protocol AlbumDetailsRoutingLogic: AnyObject {
    func routeToNext()
}

protocol AlbumDetailsDataPassing: AnyObject {
    var dataStore: AlbumDetailsDataStore? { get }
}

final class AlbumDetailsRouter: AlbumDetailsDataPassing {

    private weak var viewController: AlbumDetailsViewController?
    private(set) weak var dataStore: AlbumDetailsDataStore?
    
    init(viewController: AlbumDetailsViewController?, dataStore: AlbumDetailsDataStore?) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

// MARK: - RoutingLogic

extension AlbumDetailsRouter: AlbumDetailsRoutingLogic {

    func routeToNext() {
        // configure route for next view
    }
}
