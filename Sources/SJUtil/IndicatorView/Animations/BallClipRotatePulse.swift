//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/29.
//

import Foundation
import UIKit

public class BallClipRotatePulse: IndicatorAnimation, IndicatorAnimationProtocol {
    
    func setupAnimationInLayer(layer: CALayer, size: CGSize, tintedColor: UIColor) {
        
        let duration: CFTimeInterval = 1.0
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.9, 0.57, 0.49, 0.9)
        
        smallCircle(layer: layer, size: size, tintedColor: tintedColor, duration: duration, timingFunction: timingFunction)
        bigCircle(layer: layer, size: size, tintedColor: tintedColor, duration: duration, timingFunction: timingFunction)
    }
    
    func smallCircle(layer: CALayer, size: CGSize, tintedColor: UIColor, duration: CFTimeInterval, timingFunction: CAMediaTimingFunction) {
        let scaleAnimation = self.createKeyframeAnimationWithKeyPath(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0.0, 0.3, 1.0]
        scaleAnimation.values = [NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)),
                                 NSValue(caTransform3D: CATransform3DMakeScale(0.3, 0.3, 1.0)),
                                 NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
        ]
        scaleAnimation.duration = duration
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.timingFunctions = [timingFunction, timingFunction]
        
        let circleSize: CGFloat = size.width / 2
        let circle = CALayer()
        circle.frame = CGRect(x: (layer.bounds.size.width - circleSize) / 2, y: (layer.bounds.size.height - circleSize) / 2, width: circleSize, height: circleSize)
        circle.backgroundColor = tintedColor.cgColor
        circle.cornerRadius = circleSize / 2
        circle.add(scaleAnimation, forKey: "animation")
        layer.addSublayer(circle)
    }
    
    func bigCircle(layer: CALayer, size: CGSize, tintedColor: UIColor, duration: CFTimeInterval, timingFunction: CAMediaTimingFunction) {

        // Scale animation
        let scaleAnimation = self.createKeyframeAnimationWithKeyPath(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0.0, 0.5, 1.0]
        scaleAnimation.values = [NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)),
                                 NSValue(caTransform3D: CATransform3DMakeScale(0.6, 0.6, 1.0)),
                                 NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))]
        scaleAnimation.duration = duration
        scaleAnimation.timingFunctions = [timingFunction, timingFunction]
        
        // Rotate animation
        let rotateAnimation = self.createKeyframeAnimationWithKeyPath(keyPath: "transform.rotation.z")
        rotateAnimation.values = [ 0, Double.pi, 2 * Double.pi]
        rotateAnimation.keyTimes = scaleAnimation.keyTimes
        rotateAnimation.duration = duration
        rotateAnimation.timingFunctions = [timingFunction, timingFunction]
    
        // Animation
        let animation = createAnimationGroup()
        animation.animations = [scaleAnimation, rotateAnimation]
        animation.duration = duration
        animation.repeatCount = .infinity
        
        // Draw big circle
        let circleSize = size.width
        let circle = CAShapeLayer()
        let circlePath = UIBezierPath()
        
        circlePath.addArc(withCenter: CGPoint(x: circleSize/2, y: circleSize/2),
                          radius: circleSize/2,
                          startAngle: CGFloat(-3 * Double.pi / 4),
                          endAngle: CGFloat(-Double.pi / 4),
                          clockwise: true)
        
        circlePath.move(to: CGPoint(x: circleSize/2-circleSize/2*CGFloat(cosf(Float(Double.pi/4))),
                                    y: circleSize/2+circleSize/2*CGFloat(sinf(Float(Double.pi/4)))))
        
        circlePath.addArc(withCenter: CGPoint(x: circleSize/2, y: circleSize/2),
                          radius: circleSize/2,
                          startAngle: CGFloat(-5 * Double.pi / 4),
                          endAngle: CGFloat(-7 * Double.pi / 4),
                          clockwise: false)
        
        circle.path = circlePath.cgPath
        circle.lineWidth = 2
        circle.fillColor = nil
        circle.strokeColor = tintedColor.cgColor

        circle.frame = CGRect(x: (layer.bounds.size.width - circleSize) / 2,
                              y: (layer.bounds.size.height - circleSize) / 2,
                              width: circleSize,
                              height: circleSize)
        
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
    }
}
