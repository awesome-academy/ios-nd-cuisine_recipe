//
//  UIImageView+.swift
//  CuisineRecipe
//
//  Created by mac on 5/3/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

private enum ImageProperties {
    static let imageCache = NSCache<AnyObject, AnyObject>()
}

extension UIImageView {
    func setupGradientBarBottom(width: CGFloat, height: CGFloat) {
        let shadow = UIColor(hexString: "464646").withAlphaComponent(0.6).cgColor
        
        // Add gradient bar for image on bottom
        let bottomImageGradient = CAGradientLayer()
        bottomImageGradient.colors = [UIColor.clear.cgColor, shadow]
        bottomImageGradient.locations = [0.5, 1]
        
        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.translatesAutoresizingMaskIntoConstraints = false
        gradientContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        gradientContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientContainerView.layer.addSublayer(bottomImageGradient)
        
        bottomImageGradient.frame = CGRect(x: 0, y: 0, width: width, height: height)
        bottomImageGradient.frame.origin.y -= bounds.height
    }
    
    func loadImageFromUrl(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = ImageProperties.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let dataImage = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: dataImage) else { return }
                self.image = imageToCache
                ImageProperties.imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
            }
        }
    }
}
