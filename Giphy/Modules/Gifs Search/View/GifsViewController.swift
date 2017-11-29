//
//  GifsViewController.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit

class GifsViewController: UIViewController {
    
    // MARK: - Properties
    
    var dataManager: GifsDataManagerProtocol! {
        didSet {
            dataManager.onGifItemSelectedAction = { [unowned self] in
                self.presenter.didSelect(gif: $0, image: $1)
            }
            dataManager.onScrolledToBottomAction = { [unowned self] in
                self.presenter.didScrolledToBottom()
            }
        }
    }
    var presenter: GifsViewOutput!
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.delegate = self
        search.placeholder = LocalizableStrings.Modules.GifsSearch.searchBarPlaceholder
        search.showsCancelButton = true
        
        search.sizeToFit()
        return search
    }()
    
    private lazy var refreshControll: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: LocalizableStrings.Modules.GifsSearch.refreshControlTitle)
        refresh.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        refresh.sizeToFit()
        return refresh
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var gifsCollectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        presenter.viewIsReady()
    }
    
}

// MARK: - GifsViewInput

extension GifsViewController: GifsViewInput {
    
    func show(gifs: [Gif]) {
        if refreshControll.isRefreshing {
            refreshControll.endRefreshing()
        }
        dataManager.setup(with: gifs)
    }
    
    func showMore(gifs: [Gif]) {
        dataManager.appendNew(gifs: gifs)
    }
    
    func register3DTouchInteractions() {
        registerForPreviewing(with: self, sourceView: view)
    }
    
}

// MARK: - UIRefreshControll

extension GifsViewController {
    
    @objc private func pullToRefresh() {
        presenter.reloadData()
    }
    
}

// MARK: - UISearchBarDelegate

extension GifsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        presenter.didChangedScope(in: searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.didCancelButtonTapped(in: searchBar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.didSearchButtonTapped(in: searchBar)
    }
    
}

// MARK: - UIViewControllerPreviewingDelegate

@available(iOS 9.0, *)
extension GifsViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        return presenter.previewingContext(previewingContext: previewingContext, viewControllerForLocation: location)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        presenter.previewingContext(previewingContext: previewingContext, commit: viewControllerToCommit)
    }
    
}

// MARK: - Private

extension GifsViewController {
    
    private func configureViews() {
        navigationItem.titleView = searchBar
        
        dataManager.collectionView = gifsCollectionView
        gifsCollectionView.dataSource = dataManager
        gifsCollectionView.delegate = dataManager
        gifsCollectionView.alwaysBounceVertical = true
        gifsCollectionView.refreshControl = refreshControll
    }
    
}
