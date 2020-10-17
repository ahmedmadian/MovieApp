//
//  UIImageView + Caching.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {

    func loadImageFromUrl(url: URL)  {
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage{
            self.image = imageFromCache
            return
        }
        self.showLoader()
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.hideLoader()
                        imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }

}

extension UIImageView {

    var activity: UIActivityIndicatorView  {
        let activity = UIActivityIndicatorView()
        activity.style = .medium
        self.addSubview(activity)
        activity.pinToSuperview(forAtrributes: [.centerX, .centerY])
        return activity
    }

    func showLoader() {
        self.bringSubviewToFront(activity)
        activity.isHidden = false
        activity.startAnimating()
    }

    func hideLoader() {
        activity.isHidden = true
        activity.stopAnimating()
    }
}
