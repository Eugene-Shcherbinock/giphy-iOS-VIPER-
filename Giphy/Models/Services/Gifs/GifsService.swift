//
//  GifsDataSource.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation

typealias GifsResponseHandler = ((GifsFetchResult) -> Void)

struct GifsFetchQuery {
    var query: String
    var limit: Int = 0
    var offset: Int = 0
    var endpoint: GifsSourceEndpoint
}

struct GifsFetchResult {
    var gifs: [Gif] = []
    var offset: Int = 0
    var totalItems: Int?
    var error: APIError?
}

protocol GifsServiceProtocol: class {
    
    func fetchGifs(with query: GifsFetchQuery, _ completion: @escaping GifsResponseHandler)
    
}

class GifsService: GifsServiceProtocol {
    
    func fetchGifs(with query: GifsFetchQuery, _ completion: @escaping GifsResponseHandler) {
        APIGifs.fetchGifs(query: query.query, limit: query.limit, offset: query.offset, endpoint: query.endpoint) { (result) in
            var fetchResult = GifsFetchResult()
            
            defer {
                completion(fetchResult)
            }
            
            guard let value = result.value else {
                fetchResult.error = result.error
                return
            }
            
            fetchResult.gifs = value.data
            fetchResult.offset = value.pagination.offset
            fetchResult.totalItems = value.pagination.totalCount
        }
    }
    
}
