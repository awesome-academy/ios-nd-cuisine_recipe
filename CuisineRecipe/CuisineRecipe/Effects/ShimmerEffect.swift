//
//  ShimmerEffect.swift
//  CuisineRecipe
//
//  Created by mac on 5/3/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

final class ShimmerView: UIView {
    //shimmer Property
    let bgImageView: UIImageView = {
        let bg = UIImageView(image: UIImage(named: "shimmer1"))
        bg.contentMode = .scaleAspectFit
        return bg
    }()
    
    let shimmerImageView: UIImageView = {
        let bg = UIImageView(image: UIImage(named: "shimmer2"))
        bg.contentMode = .scaleAspectFit
        return bg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShimmeringImage()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Shimmer Animation
    fileprivate func setupShimmeringImage() {
        self.alpha = 0.0
        bgImageView.frame = self.frame
        shimmerImageView.frame = self.frame
        
        self.addSubview(shimmerImageView)
        self.addSubview(bgImageView)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]
        
        gradientLayer.locations = [0, 0.2, 0.4, 0.6, 0.8, 1]
        
        let angle = -60 * CGFloat.pi / 180
        let rotationTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        gradientLayer.transform = rotationTransform
        self.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.frame
        bgImageView.layer.mask = gradientLayer
        
        gradientLayer.transform = CATransform3DConcat(gradientLayer.transform, CATransform3DMakeScale(3, 3, 0))
    
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 1
        animation.repeatCount = Float.infinity
        animation.autoreverses = false
        animation.fromValue = -3.0 * self.frame.width
        animation.toValue = 3.0 * self.frame.width
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        gradientLayer.add(animation, forKey: "shimmerKey")
    }
}
