//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/29.
//

import Foundation
import UIKit

public class BallGridPulse: IndicatorAnimation, IndicatorAnimationProtocol {
    func setupAnimationInLayer(layer: CALayer, size: CGSize, tintedColor: UIColor) {
        
        let durations:[Float] = [0.72, 1.02, 1.28, 1.42, 1.45, 1.18, 0.87, 1.45, 1.06]
        let timeOffsets:[Float] = [-0.06, 0.25, -0.17, 0.48, 0.31, 0.03, 0.46, 0.78, 0.45]
        let timingFunction = CAMediaTimingFunction(name: .default)
        let circleSpacing: CGFloat = 2
        let circleSize = (size.width - circleSpacing * 2) / 3
        let x: CGFloat = (layer.bounds.size.width - size.width) / 2
        let y: CGFloat = (layer.bounds.size.height - size.height) / 2
        
        // Scale animation
        let scaleAnimation = self.createKeyframeAnimationWithKeyPath(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0.0, 0.5, 1.0]
        scaleAnimation.values = [1.0, 0.5, 1.0]
        scaleAnimation.timingFunctions = [timingFunction, timingFunction]
        
        // opacity animation
        let opacityAnimation = self.createKeyframeAnimationWithKeyPath(keyPath: "opacity")
        opacityAnimation.keyTimes = [0.0, 0.5, 1.0]
        opacityAnimation.values = [1.0, 0.7, 1.0]
        opacityAnimation.timingFunctions = [timingFunction, timingFunction]
        
        // Animation
        let animation = createAnimationGroup()
        animation.animations = [scaleAnimation, opacityAnimation]
        animation.beginTime = CACurrentMediaTime()
        animation.repeatCount = .infinity
        
        for i in (0..<3) {
            for j in (0..<3) {
                
                let circle = self.createCirle(with: circleSize, color: tintedColor)
                
                animation.duration = CFTimeInterval(durations[3 * i + j])
                animation.timeOffset = CFTimeInterval(timeOffsets[3 * i + j])
                circle.frame = CGRect(x: x + circleSize * CGFloat(j) + circleSpacing * CGFloat(j),
                                      y: y + circleSize * CGFloat(i) + circleSpacing * CGFloat(i),
                                      width: circleSize,
                                      height: circleSize)
                circle.add(animation, forKey: "animation")
                layer.addSublayer(circle)
            }
        }
                                       
    }
    
    func createCirle(with size: CGFloat, color: UIColor?) -> CALayer {
        let circle = CAShapeLayer()
        let circlePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size, height: size), cornerRadius: size / 2)

        circle.fillColor = color?.cgColor
        circle.path = circlePath.cgPath

        return circle
    }
}
