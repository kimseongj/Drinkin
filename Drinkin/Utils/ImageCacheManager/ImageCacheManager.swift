//
//  ImageCacheManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/11.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()

    private init() {}
}
