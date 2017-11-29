//
//  Pagination.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/2/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation
import ObjectMapper

struct Pagination: Mappable {
    
    var totalCount: Int?
    var count: Int!
    var offset: Int!
    
    init?(map: Map) {}
    
    init?(json: [String : Any]) {
        guard let totalCount = json["total"] as? Int, let count = json["count"] as? Int,
            let offset = json["offset"] as? Int else {
                return nil
        }
        self.totalCount = totalCount
        self.count = count
        self.offset = offset
    }
    
    mutating func mapping(map: Map) {
        totalCount <- map["total_count"]
        count <- map["count"]
        offset <- map["offset"]
    }
    
}
