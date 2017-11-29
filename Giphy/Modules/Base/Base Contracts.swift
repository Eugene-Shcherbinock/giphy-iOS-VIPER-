//
//  Base Contracts.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/2/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit

protocol BaseViewInput: class {

    func showLoading(_ show: Bool)
    func showError(message: String)
    
}

protocol BaseViewOutput: class {
    
    func viewIsReady()
    
}

protocol BaseInteractorInput: class {}

protocol BaseInteractorOutput: class {}

protocol BaseRouter: class {}
