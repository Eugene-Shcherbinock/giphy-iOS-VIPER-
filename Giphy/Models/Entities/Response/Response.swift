//
//  Response.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/2/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation
import ObjectMapper

struct APIError: Mappable {
    
    var message: String!
    
    init(error: Error) {
        message = error.localizedDescription
    }
    
    init?(map: Map) {
        self.init(json: map.JSON)
    }
    
    init?(json: [String : Any]) {
        guard let message = json["message"] as? String else {
            return nil
        }
        self.message = message
    }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
    }
    
}

struct Response <T: Mappable>: Mappable {
    
    var data: T!
    var meta: Meta!
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        data <- map["data"]
        meta <- map["meta"]
    }
    
}

struct PaginatableResponse <T: Mappable>: Mappable {
    
    var data: [T]!
    var meta: Meta!
    var pagination: Pagination!
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        data <- map["data"]
        meta <- map["meta"]
        pagination <- map["pagination"]
    }
    
}
