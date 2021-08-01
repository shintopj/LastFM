//
//  AlbumDetailsPresenter.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import UIKit

protocol AlbumDetailsPresentationLogic: AnyObject {
    func present(album: AlbumViewModel)
    func present(album: AlbumDetails)
    func present(error: Error)
}

final class AlbumDetailsPresenter {

    private weak var viewController: AlbumDetailsDisplayLogic?
    
    init(viewController: AlbumDetailsDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: - PresentationLogic
extension AlbumDetailsPresenter: AlbumDetailsPresentationLogic {
   
    func present(album: AlbumViewModel) {
        viewController?.display(viewModel: album)
    }
    
    func present(album: AlbumDetails) {
        viewController?.display(viewModel: album)
    }
    
    func present(error: Error) {
        viewController?.displayError(viewModel: error)
    }
}
