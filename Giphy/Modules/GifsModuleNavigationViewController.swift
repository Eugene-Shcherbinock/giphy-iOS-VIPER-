//
//  LaunchViewController.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit

class GiftModuleNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let configurator = GifsModuleConfigurator()
        configurator.setup(with: self)
    }
    
}
