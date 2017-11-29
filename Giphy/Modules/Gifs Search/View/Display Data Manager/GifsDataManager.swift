//
//  GifsDataManager.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/2/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit
import FLAnimatedImage

typealias UICollectionViewManager = UICollectionViewDelegate & UICollectionViewDataSource

protocol GifsDataManagerProtocol: class, UICollectionViewManager {
    
    weak var collectionView: UICollectionView! { get set }
    
    var onGifItemSelectedAction: ((Gif, FLAnimatedImage?) -> Void)? { get set }
    var onScrolledToBottomAction: (() -> Void)? { get set }
    
    func getData(at: CGPoint) -> (gif: Gif, image: FLAnimatedImage?)?
    
    func setup(with gifs: [Gif])
    func appendNew(gifs: [Gif])
    
}

class GifsDataDisplayManager: NSObject, GifsDataManagerProtocol {
    
    private let itemsInRow: CGFloat = 2.0
    private let spaceBetweenItems: CGFloat = 10.0
    
    // MARK: - Properties
    
    var collectionView: UICollectionView! {
        didSet {
            noContentLabel.center = collectionView.center
            collectionView.addSubview(noContentLabel)
        }
    }
    
    var onGifItemSelectedAction: ((Gif, FLAnimatedImage?) -> Void)?
    var onScrolledToBottomAction: (() -> Void)?
    
    // MARK: - Private Properties
    
    private var dataSource: [Gif] = [] {
        didSet {
            noContentLabel.isHidden = !dataSource.isEmpty
        }
    }
    
    private lazy var noContentLabel: UILabel = {
        let label = UILabel()
        
        label.text = LocalizableStrings.Modules.GifsSearch.noContentLabelText
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        
        label.isHidden = true
        return label
    }()
    
    // MARK: - GifsDataManagerProtocol
    
    func getData(at location: CGPoint) -> (gif: Gif, image: FLAnimatedImage?)? {
        let convertedLocation = collectionView.convert(location, from: collectionView.superview)
        guard let indexPath = collectionView.indexPathForItem(at: convertedLocation) else {
            return nil
        }
        return (dataSource[indexPath.row], getCell(at: indexPath)?.image)
    }
    
    func setup(with gifs: [Gif]) {
        registerCells()
        
        dataSource = gifs
        collectionView.reloadData()
    }
    
    func appendNew(gifs: [Gif]) {
        dataSource.append(contentsOf: gifs)
        
        let insertionIndexes = IndexPath.array(from: dataSource.count - gifs.count, to: dataSource.count)
        collectionView.insertItems(at: insertionIndexes)
    }
    
}

// MARK: - UICollectionViewDataSource

extension GifsDataDisplayManager {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.isEmpty ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifCollectionViewCell.reuseIdentifier, for: indexPath) as! GifCollectionViewCell
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GifsDataDisplayManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(spaceBetweenItems, spaceBetweenItems, spaceBetweenItems, spaceBetweenItems)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetweenItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetweenItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionPadding = spaceBetweenItems * (itemsInRow + 1)
        let availableWidth = collectionView.bounds.width - sectionPadding
        let widthPerItem = availableWidth / itemsInRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
}

// MARK: - UICollectionViewDelegate

extension GifsDataDisplayManager {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= dataSource.count - 4 {
            onScrolledToBottomAction?()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onGifItemSelectedAction?(dataSource[indexPath.row], getCell(at: indexPath)?.image)
    }
    
}

// MARK: - Private

extension GifsDataDisplayManager {
    
    private func registerCells() {
        let cellNib = UINib(nibName: GifCollectionViewCell.reuseIdentifier, bundle: Bundle(for: GifCollectionViewCell.cellClass))
        collectionView.register(cellNib, forCellWithReuseIdentifier: GifCollectionViewCell.reuseIdentifier)
    }
    
    private func getCell(at indexPath: IndexPath) -> GifCollectionViewCell? {
        return collectionView.cellForItem(at: indexPath) as? GifCollectionViewCell
    }
    
}
