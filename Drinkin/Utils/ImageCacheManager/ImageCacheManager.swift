//
//  ImageCacheManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/11.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()

    let cache: NSCache<NSString, UIImage>

    private init() {
        self.cache = NSCache<NSString, UIImage>()
        self.cache.totalCostLimit = 1024 * 1024 * 50
    }
}
