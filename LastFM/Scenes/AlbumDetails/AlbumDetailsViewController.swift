//
//  AlbumDetailsViewController.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import UIKit

protocol AlbumDetailsDisplayLogic: AnyObject {
    func display(viewModel: AlbumViewModel)
    func display(viewModel: AlbumDetails)
    func displayError(viewModel: Error)
}

final class AlbumDetailsViewController: UICollectionViewController {

    var interactor: AlbumDetailsBusinessLogic!
    var router: (AlbumDetailsRoutingLogic & AlbumDetailsDataPassing)!

    var album: AlbumViewModel?
    var tracks = [TrackViewModel]()
    
    let sectionHeaderId = "SectionHeaderReusableView"
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.getDetails()
        
        collectionView.register(AlbumDetailsCell.self)
        collectionView.register(TrackListCell.self)
        
        let headerNib = UINib(nibName: sectionHeaderId, bundle: Bundle.main)
        collectionView.register(headerNib, forSupplementaryViewOfKind: sectionHeaderId, withReuseIdentifier: sectionHeaderId)
        
        collectionView.collectionViewLayout = createLayout()
    }
}

// MARK: - DisplayLogic

extension AlbumDetailsViewController: AlbumDetailsDisplayLogic {

    func display(viewModel: AlbumViewModel) {
        
        self.album = viewModel
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func display(viewModel: AlbumDetails) {

        if let items = viewModel.album?.tracks?.track {
            tracks = items.map { item in
                TrackViewModel(item: item)
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    func displayError(viewModel: Error) {
        //...
    }
}

// MARK: - CollectionView Compositional Layout
extension AlbumDetailsViewController {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, _ -> NSCollectionLayoutSection? in
            
            if section == 0 {
                return self?.detailsSectionLayout()
            } else {
                return self?.trackListSectionLayout()
            }
        }
    }
    
    private func detailsSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(74)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets.leading = 8
        section.contentInsets.trailing = 8
        
        return section
    }
    
    private func trackListSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60)))
        
        item.contentInsets.bottom = 16
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 12
        section.contentInsets.trailing = 12
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44)), elementKind: sectionHeaderId, alignment: .topLeading)
        ]
        
        return section
    }
}

extension AlbumDetailsViewController {
    
    // MARK: - Collection view data source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return tracks.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: AlbumDetailsCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.item = album
            return cell
        } else {
            let cell: TrackListCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.item = tracks[indexPath.row]
            return cell
        }
    }
    
    // MARK: - Collection view header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath) as? SectionHeaderReusableView {
            header.item = "Tracks"
            return header
        }
        
        return UICollectionReusableView()
    }
    
}

extension AlbumDetailsViewController: Routing {
    static var storyboardIdentifier: String {
        return Storyboards.album
    }
}
