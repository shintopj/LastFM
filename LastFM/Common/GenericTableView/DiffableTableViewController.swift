//
//  DiffableTableViewController.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import UIKit

enum DiffableSection {
    case main
}

class DiffableTableViewController<T: BaseTableViewCell<V>, V>: UITableViewController where V: Hashable {
    
    var dataSource: UITableViewDiffableDataSource<DiffableSection, V>! = nil
    
    var emptyView: NoContentToDisplayView?
    
    var models: [V] = [] {
        didSet {
            
            var initialSnapshot = NSDiffableDataSourceSnapshot<DiffableSection, V>()
            initialSnapshot.appendSections([.main])
            initialSnapshot.appendItems(models)
            dataSource.apply(initialSnapshot, animatingDifferences: true)
        
            if models.isEmpty {
                state = UIState(status: .noData)
            }
            showEmptyViewIfNeeded()
        }
    }
    
    var state: UIState? {
        didSet {
            showEmptyViewIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        createDataSource()
    }
    
    /// registerTableViewCells that are created using xib, not in storyboard
    func registerTableViewCells() {
        tableView.register(T.self)
    }
    
    func createDataSource() {
        
        dataSource = UITableViewDiffableDataSource<DiffableSection, V>(tableView: tableView) { (tableView: UITableView, indexPath: IndexPath, item: V) -> UITableViewCell? in
            
            let cell: T = tableView.dequeueReusableCell(for: indexPath)
            cell.item = item
            return cell
        }
        
        dataSource.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        showEmptyViewIfNeeded()
    }
    
    func showEmptyViewIfNeeded() {
        
        let shouldShow = dataSource.snapshot().itemIdentifiers.isEmpty
        
        if shouldShow {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.tableFooterView = self?.getEmptyView()
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.tableFooterView = nil
            }
        }
    }
    
    private func getEmptyView() -> UIView {
        
        var emptyFrame = self.tableView.bounds
        emptyFrame.origin = CGPoint.zero
        
        emptyFrame.size.height -= self.view.safeAreaInsets.bottom + self.view.safeAreaInsets.top
        
        if emptyView == nil {
            emptyView = NoContentToDisplayView(frame: emptyFrame)
        } else {
            emptyView?.frame = emptyFrame
        }
        
        emptyView?.state = state
        return emptyView ?? UIView()
    }
}
