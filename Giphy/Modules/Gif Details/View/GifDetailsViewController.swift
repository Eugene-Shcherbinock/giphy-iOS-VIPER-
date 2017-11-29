//
//  GifDetailsViewController.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/24/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit
import FLAnimatedImage

class GifDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: GifDetailsViewOutput!
    
    // MARK: - Private Properties
    
    private lazy var gifImageView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView(frame: gifContainerView.bounds)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var actionBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didActionButtonTapped(_:)))
        return button
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var gifContainerView: UIView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        presenter.viewIsReady()
    }
    
    @IBAction func didPanGestureRecognized(_ sender: UIPanGestureRecognizer) {
        presenter.didPanGestureRecognized(recognizer: sender)
    }

}

// MARK: - Targets

extension GifDetailsViewController {
    
    @objc private func didActionButtonTapped(_ sender: UIBarButtonItem) {
        presenter.didActionButtonTapped(sender)
    }
    
}

// MARK: - GifDetailsViewInput

extension GifDetailsViewController: GifDetailsViewInput {
    
    func showDownloadedImage(_ image: FLAnimatedImage?) {
        gifImageView.animatedImage = image
        gifContainerView.addSubview(gifImageView)
    }
    
    func showOriginalImage(_ image: FLAnimatedImage) {
        gifImageView.animatedImage = image
    }
    
    func showActivityController(for sharingData: [Any], excludedItems: [UIActivityType]) {
        let activityController = UIActivityViewController(activityItems: sharingData, applicationActivities: nil)
        activityController.excludedActivityTypes = excludedItems
        present(activityController, animated: true, completion: nil)
    }
    
}

// MARK: - Private

extension GifDetailsViewController {
    
    private func configureViews() {
        navigationItem.rightBarButtonItem = actionBarButton
    }
    
}
