//
//  UIImageView.swift
//  CuisineRecipe
//
//  Created by mac on 5/3/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

final class CustomImageView: UIImageView {
    let imageCache = NSCache<AnyObject, AnyObject>()
    var imageUrlString: String?
    
    func loadImageFromUrl(urlString: String) {
        imageUrlString = urlString
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let dataImage = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: dataImage) else { return }
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                self.imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
            }
        }
    }
}
