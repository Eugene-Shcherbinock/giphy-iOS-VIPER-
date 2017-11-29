//
//  GifCollectionViewCell.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/23/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit
import FLAnimatedImage

class GifCollectionViewCell: BaseCollectionViewCell <Gif> {
    
    // MARK: - Properties
    
    var image: FLAnimatedImage? {
        return gifImageView.animatedImage
    }
    
    // MARK: - Private Properties
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: bounds)
        indicator.activityIndicatorViewStyle = .gray
        indicator.center = center
        return indicator
    }()
    
    private lazy var gifImageView: FLAnimatedImageView = {
        let image = FLAnimatedImageView(frame: frame)
        return image
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    // MARK: - BaseCollectionViewCell

    override func prepareForReuse() {
        super.prepareForReuse()
        showLoading(true)
    }
    
    override func configure(with item: Gif) {
        FLAnimatedImage.load(from: item.images?.downsampled?.url) { [weak self] (image) in
            self?.gifImageView.animatedImage = image
            self?.showLoading(false)
        }
    }

}

// MARK: - Private

extension GifCollectionViewCell {
    
    private func initialize() {
        contentView.addSubview(gifImageView)
        contentView.addSubview(activityIndicator)
        
        showLoading(true)
    }
    
    private func showLoading(_ show: Bool) {
        show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        
        activityIndicator.isHidden = !show
        gifImageView.isHidden = show
    }
    
}
