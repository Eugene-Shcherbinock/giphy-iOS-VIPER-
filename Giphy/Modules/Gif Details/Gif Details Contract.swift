//
//  Gif Details Contract.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/24/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit
import FLAnimatedImage

protocol GifDetailsViewInput: BaseViewInput {
    
    var presenter: GifDetailsViewOutput! { get set }
    
    func showDownloadedImage(_ image: FLAnimatedImage?)
    func showOriginalImage(_ image: FLAnimatedImage)
    
}

protocol GifDetailsViewOutput: BaseViewOutput {
    
    var view: GifDetailsViewInput! { get set }
    var router: GifDetailsRouterProtocol! { get set }
    
    var selectedGif: Gif! { get set }
    var downloadedImage: FLAnimatedImage? { get set }
    
    func viewIsReady()
    func didPanGestureRecognized(recognizer: UIPanGestureRecognizer)
    func didActionButtonTapped(_ sender: UIBarButtonItem)
    
}

protocol GifDetailsInteractorInput: BaseInteractorInput {}

protocol GifDetailsInteractorOutput: BaseInteractorOutput {}

protocol GifDetailsRouterProtocol: BaseRouter {
    
    weak var navigationController: UINavigationController? { get set }
    var gifDetailsViewController: UIViewController! { get set }
    
    func dismissDetails()
    
}
