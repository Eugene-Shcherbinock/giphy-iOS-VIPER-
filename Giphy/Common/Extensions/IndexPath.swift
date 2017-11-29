//
//  IndexPath.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/23/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit

extension IndexPath {
    
    static func array(from: Int, to: Int) -> [IndexPath] {
        guard from < to else {
            return []
        }
        
        var array = [IndexPath]()
        for i in from..<to {
            array.append(IndexPath(row: i, section: 0))
        }
        return array
    }
    
}
