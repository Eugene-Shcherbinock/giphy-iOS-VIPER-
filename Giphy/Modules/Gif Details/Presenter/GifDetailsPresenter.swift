//
//  GifDetailsPresenter.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/27/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit
import FLAnimatedImage

class GifDetailsPresenter: GifDetailsViewOutput {
    
    // MARK: - Properties
    
    var view: GifDetailsViewInput!
    var router: GifDetailsRouterProtocol!
    
    var selectedGif: Gif!
    var downloadedImage: FLAnimatedImage?
    
    // MARK: - Private Properties
    
    private var fullSizedImage: FLAnimatedImage?
    private var originalViewPosition: CGPoint!
    
    // MARK: - GifDetailsViewOutput
    
    func viewIsReady() {
        view.showDownloadedImage(downloadedImage)
        loadOriginalSizedGif()
    }
    
    func didPanGestureRecognized(recognizer: UIPanGestureRecognizer) {
        guard let contentView = recognizer.view else {
            return
        }
        
        let recognizerTranslation = recognizer.translation(in: contentView)
        
        switch recognizer.state {
        case .began:
            originalViewPosition = contentView.frame.origin
        case .changed:
            let currentX = contentView.frame.origin.x
            let currentY = contentView.frame.origin.y
            contentView.frame.origin = CGPoint(x: currentX + recognizerTranslation.x, y: currentY + recognizerTranslation.y)
            recognizer.setTranslation(.zero, in: contentView)
        case .ended:
            let gestureVelocity = recognizer.velocity(in: contentView)
            if abs(gestureVelocity.y) >= 1000 {
                router.dismissDetails()
                return
            }
            UIView.animate(withDuration: 0.2, animations: { [unowned self] in
                contentView.frame.origin = self.originalViewPosition
            })
        default:
            return
        }
    }
    
    func didActionButtonTapped(_ sender: UIBarButtonItem) {
        guard let downsampledImage = downloadedImage else {
            return
        }
        
        var exludedItems: [UIActivityType] = [.openInIBooks, .addToReadingList]
        if #available(iOS 11.0, *) {
            exludedItems.append(.markupAsPDF)
        }
        
        let sharingGifData = (fullSizedImage ?? downsampledImage).data!
        view.showActivityController(for: [sharingGifData], excludedItems: exludedItems)
    }
    
}

// MARK: - Private

extension GifDetailsPresenter {
    
    private func loadOriginalSizedGif() {
        FLAnimatedImage.load(from: selectedGif.images?.original?.url) { [weak self] (image) in
            self?.fullSizedImage = image
            guard let image = image else {
                return
            }
            self?.view.showOriginalImage(image)
        }
    }
    
}
