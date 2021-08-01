//
//  AlbumListViewController.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import Combine
import UIKit

protocol AlbumListDisplayLogic: AnyObject {
    func display(viewModel: [AlbumViewModel])
    func display(state: UIState)
}

final class AlbumListViewController: DiffableTableViewController<AlbumListCell, AlbumViewModel> {
    
    var interactor: AlbumListBusinessLogic!
    var router: (AlbumListRoutingLogic & AlbumListDataPassing)!
    
    // Search Handling
    private var searchController: UISearchController?
    lazy var resultsTableController = DiffableTableViewController<AlbumListCell, AlbumViewModel>()
    
    //holds all the cancellables
    var cancellable = [AnyCancellable]()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBarAndTableView()
        startCombineSearchDebounce()
        
        state = UIState(status: .noError, message: Strings.search, image: .loading)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = dataSource?.itemIdentifier(for: indexPath) {
            router.routeToNext(item: item)
        }
    }
    
    private func setUpSearchBarAndTableView() {
        
        let searchController = UISearchController(searchResultsController: resultsTableController)
        
        // Monitor when the search controller is presented and dismissed.
        searchController.delegate = self
        resultsTableController.tableView.delegate = self
        
        // Monitor when the search button is tapped, and start/end editing.
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.setImage(UIImage.search, for: .search, state: .normal)
        searchController.searchBar.setImage(UIImage.clear, for: .clear, state: .normal)
        
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.searchTextField.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.accessibilityIdentifier = "search_bar"
        searchController.searchBar.searchTextField.accessibilityIdentifier = "search_bar_text"
        
        /** Specify that this view controller determines how the search controller is presented.
         The search controller should be presented modally and match the physical size of this view controller.
         */
        definesPresentationContext = true
        
        let cancelButton = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        cancelButton.title = "Done"
        
        self.searchController = searchController
    }
    
    /// Initialise the publisher and subscriber for search
    func startCombineSearchDebounce() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController?.searchBar.searchTextField)
        
        publisher.map { ($0.object as? UISearchTextField)?.text ?? "" }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.current)
            .sink { [weak self] value in
                
                if value.lengthOfBytes(using: .utf8) > 2 {
                    self?.state = UIState(status: .loading)
                    self?.resultsTableController.state = UIState(status: .loading)
                    self?.interactor.fetch(query: value)
                }
            }
            
            .store(in: &cancellable)
    }    
}

extension AlbumListViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    // MARK: - Search bar delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // User tapped the Done button in the keyboard.
        searchController?.dismiss(animated: true, completion: nil)
    }
    
    // Called when the search bar's text has changed or when the search bar becomes first responder.
    func updateSearchResults(for searchController: UISearchController) {
        // Update the resultsController's filtered items based on the search terms and suggested search token.
    }
    
    // MARK: - UISearchControllerDelegate
    
    // Use these delegate functions for additional control over the search controller.
    // We are being asked to present the search controller, so from the start - show suggested searches.
    func presentSearchController(_ searchController: UISearchController) {
        searchController.showsSearchResultsController = true
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        resultsTableController.models = models
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        updateSearchAfterDismiss(searchController)
    }
    
    func updateSearchAfterDismiss(_ searchController: UISearchController) {
        let token = searchController.searchBar.searchTextField.tokens
        let searchText = searchController.searchBar.searchTextField.text
        
        // set the text back after search controller dismiss
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(50)) {
            searchController.searchBar.searchTextField.tokens = token
            searchController.searchBar.searchTextField.text = searchText
        }
    }
}

// MARK: - DisplayLogic
extension AlbumListViewController: AlbumListDisplayLogic {
    
    func display(viewModel: [AlbumViewModel]) {
        models = viewModel
        
        DispatchQueue.main.async { [weak self] in
            if self?.searchController?.isActive ?? false {
                self?.resultsTableController.models = viewModel
            }
        }
    }
    
    func display(state: UIState) {
        
        if !models.isEmpty {
            models.removeAll()
        }
        self.state = state
        
        DispatchQueue.main.async { [weak self] in
            if self?.searchController?.isActive ?? false {
                self?.resultsTableController.models.removeAll()
                self?.resultsTableController.state = state
            }
        }
    }
}

extension AlbumListViewController: Routing {
    static var storyboardIdentifier: String {
        return Storyboards.album
    }
}
