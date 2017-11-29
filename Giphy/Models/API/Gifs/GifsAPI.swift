//
//  APIGifsDataSource.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/3/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

typealias GifsResultHandler = ((Result <PaginatableResponse <Gif>>) -> Void)

enum GifsSourceEndpoint: String {
    case search
    case trending
}

enum GifsAPIRouter: URLRequestConvertible {
    
    case fetchAll(endpoint: GifsSourceEndpoint, query: String, limit: Int, offset: Int)
    
    var requestURL: String {
        switch self {
        case .fetchAll(let endpoint, let query, let limit, let offset):
            return "\(APISettings.apiURL)/gifs/\(endpoint.rawValue)?api_key=\(APISettings.apiKey)&q=\(query)&limit=\(limit)&offset=\(offset)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(string: requestURL)!)
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
}

class APIGifs {
    
    private init() {}
    
    static func fetchGifs(query: String, limit: Int, offset: Int, endpoint: GifsSourceEndpoint, _ completion: @escaping GifsResultHandler) {
        let apiRoute = GifsAPIRouter.fetchAll(endpoint: endpoint, query: query, limit: limit, offset: offset)
        
        Alamofire
            .request(apiRoute.requestURL, method: apiRoute.httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseString { (response) in
                guard let error = response.error else {
                    let json = response.value!
                    if let apiError = Mapper <APIError>().map(JSONString: json) {
                        completion(.error(apiError))
                        return
                    }
                    completion(.success(Mapper <PaginatableResponse <Gif>>().map(JSONString: json)!))
                    return
                }
                completion(.error(APIError(error: error)))
        }
    }
    
}
