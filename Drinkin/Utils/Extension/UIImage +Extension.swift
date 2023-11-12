//
//  UIImage +Extension.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/24.
//

import UIKit

extension UIImageView {
    func load(urlString: String) {
        let cacheKey = NSString(string: urlString)
        
        guard let imageURL = URL(string: urlString) else { return }
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                    ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                    self?.image = image
                }
            }
        }
    }
}

