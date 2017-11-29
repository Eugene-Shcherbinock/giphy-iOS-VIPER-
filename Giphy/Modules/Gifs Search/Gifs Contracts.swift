//
//  Gifs Contract.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit
import FLAnimatedImage

struct GifsFetchRequest {
    var query: String
    var limit: Int
    var offset: Int
    var endpoint: GifsSourceEndpoint
}

protocol GifsViewInput: BaseViewInput {
    
    var dataManager: GifsDataManagerProtocol! { get set }
    var presenter: GifsViewOutput! { get set }
    
    func show(gifs: [Gif])
    func showMore(gifs: [Gif])
    
    func register3DTouchInteractions()
    
}

protocol GifsViewOutput: BaseViewOutput, GifsInteractorOutput {
    
    var view: GifsViewInput! { get set }
    var interactor: GifsInteractorInput! { get set }
    var router: GifsRouterProtocol! { get set }
    
    func reloadData()
    func didScrolledToBottom()
    
    func didChangedScope(in searchBar: UISearchBar)
    func didCancelButtonTapped(in searchBar: UISearchBar)
    func didSearchButtonTapped(in searchBar: UISearchBar)
    
    func didSelect(gif: Gif, image: FLAnimatedImage?)
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController?
    func previewingContext(previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController)
    
}

protocol GifsInteractorInput: BaseInteractorInput {
    
    weak var output: GifsInteractorOutput? { get set }
    var gifsService: GifsServiceProtocol! { get set }
    
    var isFetchingNow: Bool { get }
    
    func fetchGifs(with request: GifsFetchRequest)
    
}

protocol GifsInteractorOutput: BaseInteractorOutput {
    
    func didFetched(gifs: [Gif])
    func didFetchedMore(gifs: [Gif])
    func didFailed(error: APIError)
    
}

protocol GifsRouterProtocol: BaseRouter {
    
    weak var navigationController: UINavigationController? { get set }
    var gifsViewController: UIViewController! { get set }
    
    func showDetails(for gif: Gif, downloadedImage: FLAnimatedImage?)
    func prepareDetails(for gif: Gif, downloadedImage: FLAnimatedImage?) -> UIViewController
    func commit(viewController: UIViewController)
    
}
