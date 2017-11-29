//
//  GifsModuleConfigurator.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit

class GifsModuleConfigurator {
    
    let viewController: UIViewController
    
    init() {
        viewController = UIStoryboard(name: "Gifs", bundle: nil).instantiateViewController(withIdentifier: GifsViewController.storyboardIdentifier)
    }
    
    func configure(with navigationController: UINavigationController?) {
        let router: GifsRouterProtocol = GifsRouter()
        let gifsView: GifsViewInput = viewController as! GifsViewInput
        let presenter: GifsViewOutput = GifsPresenter()
        let interactor: GifsInteractorInput = GifsInteractor()
        let gifsService: GifsServiceProtocol = GifsService()
        
        gifsView.dataManager = GifsDataDisplayManager()
        gifsView.presenter = presenter
        
        presenter.view = gifsView
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.gifsService = gifsService
        interactor.output = presenter
        
        viewController.title = ""
        router.gifsViewController = viewController
        router.navigationController = navigationController
    }
    
}
