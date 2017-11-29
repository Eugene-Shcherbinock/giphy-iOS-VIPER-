//
//  GifsPresenter.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit
import FLAnimatedImage

class GifsPresenter: GifsViewOutput {
    
    // MARK: - Properties
    
    weak var view: GifsViewInput!
    var interactor: GifsInteractorInput!
    var router: GifsRouterProtocol!
    
    // MARK: - Private Properties
    
    private var query: String = ""
    private var offset: Int = 0
    private var endpoint: GifsSourceEndpoint = .trending
    
    // MARK: - GifsViewOutput
    
    func viewIsReady() {
        view.showLoading(true)
        fetchGifs(with: query)
        
        tryToRegisterFor3DTouchInteractions()
    }
    
    func reloadData() {
        offset = 0
        
        view.showLoading(true)
        fetchGifs(with: query)
    }
    
    func didScrolledToBottom() {
        if interactor.isFetchingNow {
            return
        }
        
        view.showLoading(true)
        fetchGifs(with: query)
    }

    func didCancelButtonTapped(in searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func didSearchButtonTapped(in searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if query != searchBar.text {
            offset = 0
            query = searchBar.text!.replacingOccurrences(of: " ", with: "_")
            endpoint = .search
            
            view.showLoading(true)
            fetchGifs(with: query)
        }
    }
    
    func didSelect(gif: Gif, image: FLAnimatedImage?) {
        router.showDetails(for: gif, downloadedImage: image)
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let selectedCellData = view.dataManager.getData(at: location) else {
            return nil
        }
        return router.prepareDetails(for: selectedCellData.gif, downloadedImage: selectedCellData.image)
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        router.commit(viewController: viewControllerToCommit)
    }
    
}

// MARK: - GifsInteractorOutput

extension GifsPresenter: GifsInteractorOutput {
    
    func didFetched(gifs: [Gif]) {
        offset += gifs.count
        
        view.showLoading(false)
        view.show(gifs: gifs)
    }
    
    func didFetchedMore(gifs: [Gif]) {
        offset += gifs.count
        
        view.showLoading(false)
        view.showMore(gifs: gifs)
    }
    
    func didFailed(error: APIError) {
        view.showLoading(false)
        view.showError(message: error.message)
    }
    
}

// MARK: - Private

extension GifsPresenter {
    
    private func fetchGifs(with query: String, limit: Int = 20) {
        let fetchRequest = GifsFetchRequest(query: query, limit: limit, offset: offset, endpoint: endpoint)
        interactor.fetchGifs(with: fetchRequest)
    }
    
    private func is3DTouchAvailable() -> Bool {
        guard #available(iOS 9.0, *), router.gifsViewController.traitCollection.forceTouchCapability == .available else {
            return false
        }
        return true
    }
    
    private func tryToRegisterFor3DTouchInteractions() {
        let viewController = router.gifsViewController
        guard is3DTouchAvailable(), let previewingDelegate = viewController as? UIViewControllerPreviewingDelegate else {
            return
        }
        viewController!.registerForPreviewing(with: previewingDelegate, sourceView: viewController!.view)
    }
    
}
