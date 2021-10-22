//
//  File.swift
//  
//
//  Created by Eileen on 2021/8/3.
//

import Foundation
import UIKit

open class ShimmerView:UIView {
    
    private var gradientColorOne : CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    private var gradientColorTwo : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
    
    private var gradientLayer:CAGradientLayer!
    private var animating = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addGradientLayer() -> CAGradientLayer? {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [-1.0, -0.5, 0.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    public func addAnimation(duration: Double = 0.9, repeatCount: Float = .infinity) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = repeatCount
        animation.duration = duration
        animation.delegate = self
        return animation
    }
    
    public func stopAnimating() {
        guard let  gradientLayer = gradientLayer  else { return }
        gradientLayer.removeFromSuperlayer()
        gradientLayer.removeAllAnimations()
        self.gradientLayer = nil
        animating = false
    }
    
    public func startAnimating() {
        if !animating {
            animating = true
            gradientLayer = self.addGradientLayer()
            let animation = self.addAnimation()
            gradientLayer?.add(animation, forKey: "anim")
        }
    }
}

extension ShimmerView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished: Bool) {
        animating = false
        if finished {
            gradientLayer?.removeFromSuperlayer()
            gradientLayer = nil;
        }
    }
}
