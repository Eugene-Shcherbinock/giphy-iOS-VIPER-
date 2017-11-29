//
//  PropertyListLoader.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation

class PropertyListLoader {
    
    class func load(_ name: String = "Info") -> [String : Any] {
        guard let filePath = Bundle(for: self).path(forResource: name, ofType: "plist") else {
            return [:]
        }
        return NSDictionary(contentsOfFile: filePath) as! [String : Any]
    }
    
}
