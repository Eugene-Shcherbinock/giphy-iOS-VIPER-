//
//  Result.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation

enum Result <Value> {
    case success(Value)
    case error(APIError)
    
    var value: Value? {
        switch self {
        case let .success(value):
            return value
        case .error:
            return nil
        }
    }
    
    var error: APIError? {
        switch self {
        case .success:
            return nil
        case let .error(error):
            return error
        }
    }
    
    init(value: Value?, error: APIError?) {
        if let value = value {
            self = .success(value)
        } else {
            let unknownError: Error = NSError()
            self = .error(error ?? APIError(error: unknownError))
        }
    }
    
}
