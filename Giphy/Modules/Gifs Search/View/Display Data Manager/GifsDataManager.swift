//
//  GifsDataManager.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/2/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit

typealias UICollectionViewManager = UICollectionViewDelegate & UICollectionViewDataSource

protocol GifsDataManagerProtocol: class, UICollectionViewManager {
    
    weak var collectionView: UICollectionView! { get set }
    var dataSource: [Gif]?
    
}

class GifsDataDisplayManager: NSObject, GifsDataManagerProtocol {
    
    // MARK: - Properties
    
    var collectionView: UICollectionView!
    var dataSource: [Gif]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - GifsDataManagerProtocol
    
    
    
}

// MARK: - UICollectionViewDataSource

extension GifsDataDisplayManager {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gifsDataSource.isEmpty ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifsDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GifsDataDisplayManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 20, height: 20)
    }
    
}

// MARK: - UICollectionViewDelegate

extension GifsDataDisplayManager {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
