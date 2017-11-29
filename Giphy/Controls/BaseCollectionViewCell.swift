//
//  BaseCollectionViewCell.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/23/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit

class BaseCollectionViewCell <T>: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var cellClass: UICollectionViewCell.Type {
        return self
    }
    
    func configure(with item: T) {
        print("Abstract method")
    }
    
}
