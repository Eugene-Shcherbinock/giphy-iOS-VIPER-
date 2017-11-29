//
//  GifsRouter.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit
import FLAnimatedImage

class GifsRouter: GifsRouterProtocol {
    
    weak var navigationController: UINavigationController?
    var gifsViewController: UIViewController!
    
    func showDetails(for gif: Gif, downloadedImage: FLAnimatedImage?) {
        let detailsController = prepareDetails(for: gif, downloadedImage: downloadedImage)
        commit(viewController: detailsController)
    }
    
    func prepareDetails(for gif: Gif, downloadedImage: FLAnimatedImage?) -> UIViewController {
        let gifDetailsConfigurator = GifDetailsModuleConfigurator()
        gifDetailsConfigurator.configure(for: gif, downloadedImage: downloadedImage, in: navigationController)
        return gifDetailsConfigurator.viewController
    }
    
    func commit(viewController: UIViewController) {
        guard let navigationController = navigationController else {
            
            return
        }
        
        navigationController.hidesBarsOnTap = true
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
