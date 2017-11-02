//
//  GifsDataSource.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation

typealias GifsResponse = Result <[]>

protocol GifsDataSource: class {
    
    func fetchGifs(query: String, limit: Int = 10, offset: Int = 0, _ completion: @escaping([String]?, Error?) -> Void)
    
}
