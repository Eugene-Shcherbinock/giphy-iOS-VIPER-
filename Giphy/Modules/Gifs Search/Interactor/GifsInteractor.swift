//
//  GifsInteractor.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation

class GifsInteractor: GifsInteractorInput {
    
    // MARK: - Properties
    
    weak var output: GifsInteractorOutput?
    var gifsService: GifsServiceProtocol!
    
    var isFetchingNow: Bool = false
    
    // MARK: - Private Properties
    
    private var fetchResult: GifsFetchResult?
    
    // MARK: - GifsInteractorInput
    
    func fetchGifs(with request: GifsFetchRequest) {
        isFetchingNow = true
        
        let fetchQuery = GifsFetchQuery(query: request.query, limit: request.limit, offset: request.offset, endpoint: request.endpoint)
        gifsService.fetchGifs(with: fetchQuery) { [weak self] (result) in
            self?.handleFetch(result: result, for: request)
        }
    }
    
}

// MARK: - Private Methods

extension GifsInteractor {
    
    private func handleFetch(result: GifsFetchResult, for request: GifsFetchRequest) {
        isFetchingNow = false
        
        guard result.error == nil else {
            output?.didFailed(error: result.error!)
            return
        }
        
        let isFirstLoading = (request.offset == 0)
        if isFirstLoading {
            output?.didFetched(gifs: result.gifs)
            return
        }
        output?.didFetchedMore(gifs: result.gifs)
    }
    
}
