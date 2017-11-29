//
//  Gif.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation
import ObjectMapper

struct Gif: Mappable {
    
    var id: String!
    var title: String!
    var slug: String!
    var url: String!
    var source: String!
    var rating: String!
    var sourcePostUrl: String!
    var images: GifImages?
    
    init?(map: Map) {}
    
    init?(json: [String : Any]) {
        guard let id = json["id"] as? String, let title = json["title"] as? String, let slug = json["slug"] as? String,
            let url = json["url"] as? String, let source = json["source"] as? String,
            let rating = json["rating"] as? String, let sourcePostUrl = json["source_post_url"] as? String else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.slug = slug
        self.url = url
        self.source = source
        self.rating = rating
        self.images = GifImages(json: json["images"] as! [String : Any])
        self.sourcePostUrl = sourcePostUrl
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        slug <- map["slug"]
        url <- map["url"]
        source <- map["source"]
        rating <- map["rating"]
        sourcePostUrl <- map["source_post_url"]
        images <- map["images"]
    }
    
}
