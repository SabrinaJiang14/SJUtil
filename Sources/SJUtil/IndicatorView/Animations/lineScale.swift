//
//  lineScale.swift
//  testAnimation
//
//  Created by Eileen on 2021/6/30.
//

import Foundation
import UIKit

public class lineScale: IndicatorAnimation, IndicatorAnimationProtocol {
    func setupAnimationInLayer(layer: CALayer, size: CGSize, tintedColor: UIColor) {
        let duration:CFTimeInterval = 1.0
        let beginTimes:[Double] = [0.1, 0.2, 0.3, 0.4, 0.5];
        
        let timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 0.18)
        let lineSize:CGFloat = size.width / 9
        let x = (layer.bounds.size.width - size.width)/2
        let y = (layer.bounds.size.height - size.height)/2
        
        // Animation
        let animation: CAKeyframeAnimation = self.createKeyframeAnimationWithKeyPath(keyPath: "transform.scale.y")
        animation.keyTimes = [0.0, 0.5, 1.0]
        animation.values = [1.0, 0.4, 1.0]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.repeatCount = .infinity
        animation.duration = duration
        
        for i in (0..<5) {
            let line: CAShapeLayer = CAShapeLayer()
            let linePath: UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: lineSize, height: size.height), cornerRadius: lineSize/2)
            animation.beginTime = beginTimes[i]
            line.fillColor = tintedColor.cgColor
            line.path = linePath.cgPath
            line.add(animation, forKey: "animation")
            line.frame = CGRect(x: x+lineSize*2*CGFloat(i),
                                y: y,
                                width: lineSize,
                                height: size.height)
            layer.addSublayer(line)
        }
    }
}
