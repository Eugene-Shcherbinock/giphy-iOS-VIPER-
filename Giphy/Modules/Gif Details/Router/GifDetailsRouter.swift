//
//  GifDetailsRouter.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/27/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit

class GifDetailsRouter: GifDetailsRouterProtocol {
    
    weak var navigationController: UINavigationController?
    var gifDetailsViewController: UIViewController!
    
    func dismissDetails() {
        guard let navigationController = navigationController else {
            gifDetailsViewController.dismiss(animated: true, completion: nil)
            return
        }
        
        navigationController.hidesBarsOnTap = false
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.popViewController(animated: true)
    }
    
}
