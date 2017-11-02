//
//  Gifs Contract.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit

protocol GifsViewInput: class {
    
    var presenter: GifsViewOutput! { get set }
    
    func show(gifs: [Gif])
    
}

protocol GifsViewOutput: GifsInteractorOutput {
    
    weak var view: GifsViewInput! { get set }
    var interactor: GifsInteractorInput! { get set }
    var router: GifsRouterProtocol! { get set }
    
    func viewDidLoad()
    
    func didChangedQuery(in searchBar: UISearchBar)
    func didChangedScope(in searchBar: UISearchBar)
    func didSearchButtonTapped(in searchBar: UISearchBar)
    
    func configure(cell: UICollectionViewCell, at indexPath: IndexPath)
    func didSelect(gif: Gif, at indexPath: IndexPath)
    
}

protocol GifsInteractorInput: class {
    
    weak var output: GifsInteractorOutput! { get set }
    var dataSource: GifsDataSource! { get set }
    
    func fetchGifsWith(query: String, limit: Int, offset: Int)
    
}

protocol GifsInteractorOutput: class {
    
    func didFetched(gifs: [Gif])
    func didFailed(error: Error)
    
}

protocol GifsRouterProtocol: class {
    
    func showDetails(for gif: Gif)
    
}
