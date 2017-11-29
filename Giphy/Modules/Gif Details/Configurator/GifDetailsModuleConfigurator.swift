//
//  GifDetailsModuleConfigurator.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/24/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit
import FLAnimatedImage

class GifDetailsModuleConfigurator {
    
    let viewController: UIViewController
    
    init() {
        viewController = UIStoryboard(name: "GifDetails", bundle: nil).instantiateViewController(withIdentifier: GifDetailsViewController.storyboardIdentifier)
    }
    
    func configure(for gif: Gif, downloadedImage: FLAnimatedImage?, in navigationController: UINavigationController?) {
        let router: GifDetailsRouterProtocol = GifDetailsRouter()
        let view: GifDetailsViewInput = viewController as! GifDetailsViewInput
        let presenter: GifDetailsViewOutput = GifDetailsPresenter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.selectedGif = gif
        presenter.downloadedImage = downloadedImage
        
        viewController.title = LocalizableStrings.Modules.GifDetails.title
        router.navigationController = navigationController
        router.gifDetailsViewController = viewController
    }
    
}
