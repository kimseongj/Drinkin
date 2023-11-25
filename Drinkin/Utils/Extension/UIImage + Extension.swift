//
//  UIImage + Extension.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/24.
//

import UIKit

extension UIImageView {
    func load(urlString: String, completion: @escaping () -> Void) {
        let cacheKey = NSString(string: urlString)
        guard let imageURL = URL(string: urlString) else { return }
        
        if let cachedImage = ImageCacheManager.shared.cache.object(forKey: cacheKey) {
            self.image = cachedImage
            
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                    ImageCacheManager.shared.cache.setObject(image, forKey: cacheKey)
                    self.image = image
                    completion()
                }
            }
        }
    }
}

extension UIImageView {
    func showActivityIndicator(style: UIActivityIndicatorView.Style = .large) {
            let indicator = UIActivityIndicatorView(style: style)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.hidesWhenStopped = true
            addSubview(indicator)

            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        indicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        if let activityIndicator = subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
