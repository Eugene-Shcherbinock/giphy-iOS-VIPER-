//
//  Meta.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/3/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation
import ObjectMapper

struct Meta: Mappable {
    
    var status: Int!
    var message: String!
    var responseID: String!
    
    init?(map: Map) {}
    
    init?(_ json: [String : Any]) {
        guard let status = json["status"] as? Int, let message = json["msg"] as? String,
            let responseID = json["response_id"] as? String else {
                return nil
        }
        self.status = status
        self.message = message
        self.responseID = responseID
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        message <- map["msg"]
        responseID <- map["response_id"]
    }
    
}
