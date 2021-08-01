//
//  AlbumListPresenter.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import LastFMNetwork
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
            viewController?.display(state: UIState(status: .noData, message: Strings.noSearchResult))
        } else {
            
            let viewModel = albums.map { album in
                AlbumViewModel(album: album)
            }
            viewController?.display(viewModel: viewModel)
        }
    }
    
    func present(error: Error) {
        
        if let error = error as? APIError {
            
            switch error {
            case .noNetwork:
                viewController?.display(state: UIState(status: .noNetwork))
                
            case let .apiError(reason):
                viewController?.display(state: UIState(status: .error, message: reason))
                
            default:
                viewController?.display(state: UIState(status: .error, message: error.localizedDescription))
            }
        }
    }
}
