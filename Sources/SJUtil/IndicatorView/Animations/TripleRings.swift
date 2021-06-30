//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/29.
//

import Foundation
import UIKit

public class TripleRings : IndicatorAnimation, IndicatorAnimationProtocol {
    
    func setupAnimationInLayer(layer: CALayer, size: CGSize, tintedColor: UIColor) {
        let beginTime: CFTimeInterval = CACurrentMediaTime()
        
        let path: UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size.width, height: size.width))
        let oX: CGFloat = (layer.bounds.size.width - size.width)/2
        let oY: CGFloat = (layer.bounds.size.height - size.height)/2
        
        for i in (0..<3) {
            let circle: CAShapeLayer = CAShapeLayer()
            circle.path = path.cgPath
            circle.fillColor = UIColor.clear.cgColor
            circle.strokeColor = tintedColor.cgColor
            circle.frame = CGRect(x: oX, y: oY, width: size.width, height: size.height)
            circle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            circle.opacity = 1.0
            circle.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
            
            let transformAnimation: CABasicAnimation = self.createBasicAnimationWithKeyPath(keyPath: "transform")
            transformAnimation.duration = 2.0 - Double(i) - 0.4
            transformAnimation.fromValue = NSValue(caTransform3D: CATransform3DMakeScale(0.1, 0.1, 0.0))
            transformAnimation.toValue = NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 0.0))
            transformAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            
            let opacityAnimation: CABasicAnimation = self.createBasicAnimationWithKeyPath(keyPath: "opacity")
            opacityAnimation.duration = transformAnimation.duration
            opacityAnimation.fromValue = NSNumber(value: 1.0)
            opacityAnimation.toValue = NSNumber(value: 0.8)
            opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            
            let animationGroup = self.createAnimationGroup()
            animationGroup.beginTime = beginTime + Double(i) * 0.4
            animationGroup.repeatCount = .infinity
            animationGroup.duration = 2.0
            animationGroup.animations = [transformAnimation, opacityAnimation]

            layer.addSublayer(circle)
            circle.add(animationGroup, forKey: "animation")
        }
    }
}
