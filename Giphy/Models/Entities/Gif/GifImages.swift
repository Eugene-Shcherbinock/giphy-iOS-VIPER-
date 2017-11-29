//
//  GifImages.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/2/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation
import ObjectMapper

struct Image: Mappable {
    
    var url: String!
    var width: String!
    var height: String!
    var size: String!
    
    init?(map: Map) {}
    
    init?(json: [String : Any]) {
        guard let url = json["url"] as? String, let width = json["width"] as? String,
            let height = json["height"] as? String, let size = json["size"] as? String else {
                return nil
        }
        
        self.url = url
        self.width = width
        self.height = height
        self.size = size
    }
    
    mutating func mapping(map: Map) {
        url <- map["url"]
        width <- map["width"]
        height <- map["height"]
        size <- map["size"]
    }
    
}

struct GifImages: Mappable {
    
    var downsampled: Image?
    var original: Image?
    
    init?(map: Map) {}
    
    init?(json: [String : Any]) {
        downsampled = Image(json: json["fixed_width_downsampled"] as! [String : Any])
        original = Image(json: json["original"] as! [String : Any])
    }
    
    mutating func mapping(map: Map) {
        downsampled <- map["fixed_width_downsampled"]
        original <- map["original"]
    }
    
}
