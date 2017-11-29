//
//  LocalizableStrings.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/26/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation

struct LocalizableStrings {
    
    struct Errors {
        static let title = NSLocalizedString("AlertController.Title", comment: "")
    }
    
    struct Modules {
        
        struct GifsSearch {
            static let searchBarPlaceholder = NSLocalizedString("GifsViewController.SearchBar.Placeholder", comment: "")
            static let refreshControlTitle = NSLocalizedString("GifsViewController.RefreshControl.Title", comment: "")
            static let noContentLabelText = NSLocalizedString("GifsViewController.NoContentLabel.Text", comment: "")
        }
        
        struct GifDetails {
            static let title = NSLocalizedString("GifDetailsViewController.Title", comment: "")
        }
        
    }
    
}
