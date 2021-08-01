//
//  AlbumListPresenter.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import UIKit

protocol AlbumListPresentationLogic: AnyObject {
    func present(albums: [Album])
    func present(error: Error)
}

final class AlbumListPresenter {

    private weak var viewController: AlbumListDisplayLogic?
    
    init(viewController: AlbumListDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: - PresentationLogic

extension AlbumListPresenter: AlbumListPresentationLogic {

    func present(albums: [Album]) {
        
        if albums.isEmpty {
            viewController?.displayError(viewModel: "No Results found that matching your query")
        } else {
            
            let viewModel = albums.map { album in
                AlbumViewModel(album: album)
            }
            viewController?.display(viewModel: viewModel)
        }
    }
    
    func present(error: Error) {
        viewController?.displayError(viewModel: error.localizedDescription)
    }
}
