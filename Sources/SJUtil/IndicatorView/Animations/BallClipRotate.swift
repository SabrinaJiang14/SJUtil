//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/30.
//

import Foundation
import UIKit

public class BallClipRotate : IndicatorAnimation, IndicatorAnimationProtocol {
    
    func setupAnimationInLayer(layer: CALayer, size: CGSize, tintedColor: UIColor) {
        let duration:CFTimeInterval = 0.75
        
        //    Scale animation
        
        let scaleAnimation: CAKeyframeAnimation = self.createKeyframeAnimationWithKeyPath(keyPath: "transform.scale")
        scaleAnimation.values = [NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)),
                                 NSValue(caTransform3D: CATransform3DMakeScale(0.6, 0.6, 1.0)),
                                 NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))]
        scaleAnimation.keyTimes = [0.0, 0.5, 1.0]
        
        // Rotate animation
        let rotateAnimation: CAKeyframeAnimation = self.createKeyframeAnimationWithKeyPath(keyPath: "transform.rotation.z")
        rotateAnimation.values = [0, Double.pi, Double.pi*2]
        rotateAnimation.keyTimes = scaleAnimation.keyTimes
        
        // Animation
        let animation: CAAnimationGroup = self.createAnimationGroup()
        animation.animations = [scaleAnimation, rotateAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        animation.repeatCount = .infinity
        
        
        // Draw ball clip
        let circle: CAShapeLayer = CAShapeLayer()
        let circlePath: UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: size.width/2, y: size.height/2),
                                                    radius: size.width/2,
                                                    startAngle: CGFloat(Double.pi*1.5),
                                                    endAngle: CGFloat(Double.pi),
                                                    clockwise: true)
        circle.path = circlePath.cgPath
        circle.lineWidth = 3.5
        circle.fillColor = nil
        circle.strokeColor = tintedColor.cgColor
        circle.frame = CGRect(x: (layer.bounds.size.width-size.width)/2, y: (layer.bounds.size.height - size.height)/2, width: size.width, height: size.height)
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
    }
}
