//
//  BaseViewController.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit
import MBProgressHUD

// MARK: - BaseViewInput

extension UIViewController: BaseViewInput {
    
    func showLoading(_ show: Bool) {
        if show {
            showLoadingIndicator(in: view)
        } else {
            hideLoadingIndicator(in: view)
        }
    }
    
    func showError(message: String) {
        let alertViewController = UIAlertController(title: LocalizableStrings.Errors.title, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
}

// MARK: - Loading

extension UIViewController {
    
    func showLoadingIndicator(in view: UIView? = UIApplication.shared.keyWindow) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let view = view else {
            return
        }
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD.isUserInteractionEnabled = false
    }
    
    func hideLoadingIndicator(in view: UIView? = UIApplication.shared.keyWindow) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        guard let view = view else {
            return
        }
        MBProgressHUD.hide(for: view, animated: true)
    }
    
}

// MARK: - Storyboard

extension UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
}
