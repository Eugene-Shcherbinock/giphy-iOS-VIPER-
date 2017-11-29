//
//  UIImage.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/23/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import FLAnimatedImage

typealias ImageCompletionHandler = ((FLAnimatedImage?) -> Void)

extension FLAnimatedImage {
    
    static func load(from url: String?, _ completion: @escaping ImageCompletionHandler) {
        guard let url = URL(string: url ?? "") else {
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(FLAnimatedImage(animatedGIFData: imageData))
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
}
