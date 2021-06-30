//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/29.
//

import Foundation
import UIKit

public class TriangleSkewSpin: IndicatorAnimation, IndicatorAnimationProtocol {

    func setupAnimationInLayer(layer: CALayer, size: CGSize, tintedColor: UIColor) {
        /*
         CGFloat duration = 3.0f;
         CGFloat x = (layer.bounds.size.width - size.width) / 2;
         CGFloat y = (layer.bounds.size.height - size.height) / 2;
         CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.09f :0.57f :0.49f :0.9f];
         */
        let duration: CFTimeInterval = 3.0
        let x: CGFloat = (layer.bounds.size.width - size.width)/2
        let y: CGFloat = (layer.bounds.size.height - size.height)/2
        let timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(controlPoints: 0.9, 0.57, 0.49, 0.9)
        
        /*
         // Rotation x animation
         CAKeyframeAnimation *rotationXAnimation = [self createKeyframeAnimationWithKeyPath:@"transform.rotation.x"];
         
         rotationXAnimation.duration = duration;
         rotationXAnimation.keyTimes = @[@0.0f, @0.25f, @0.5f, @0.75f, @1.0f];
         rotationXAnimation.values = @[@0.0f, @M_PI, @M_PI, @0.0f, @0.0f];
         rotationXAnimation.timingFunctions = @[timingFunction, timingFunction, timingFunction, timingFunction];
         */
        // Rotation x animation
        let rotationXAnimation: CAKeyframeAnimation = self.createKeyframeAnimationWithKeyPath(keyPath: "transform.rotation.x")
        rotationXAnimation.duration = duration
        rotationXAnimation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        rotationXAnimation.values = [0.0, Double.pi, Double.pi, 0.0, 0.0]
        rotationXAnimation.timingFunctions = [timingFunction, timingFunction, timingFunction, timingFunction]
        
        /*
         // Rotation x animation
         CAKeyframeAnimation *rotationYAnimation = [self createKeyframeAnimationWithKeyPath:@"transform.rotation.y"];
         
         rotationYAnimation.duration = duration;
         rotationYAnimation.keyTimes = @[@0.0f, @0.25f, @0.5f, @0.75f, @1.0f];
         rotationYAnimation.values = @[@0.0f, @0.0f, @M_PI, @M_PI, @0.0f];
         rotationYAnimation.timingFunctions = @[timingFunction, timingFunction, timingFunction, timingFunction];
         */
        // Rotation y animation
        let rotationYAnimation: CAKeyframeAnimation = self.createKeyframeAnimationWithKeyPath(keyPath: "transform.rotation.y")
        rotationYAnimation.duration = duration
        rotationYAnimation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        rotationYAnimation.values = [0.0, 0.0, Double.pi, Double.pi, 0.0]
        rotationYAnimation.timingFunctions = [timingFunction, timingFunction, timingFunction, timingFunction]
        
        /*
         // Animation
         CAAnimationGroup *animation = [self createAnimationGroup];;
         
         animation.animations = @[rotationXAnimation, rotationYAnimation];
         animation.duration = duration;
         animation.repeatCount = HUGE_VALF;
         */
        // Animation
        let animation: CAAnimationGroup = self.createAnimationGroup()
        animation.animations = [rotationXAnimation, rotationYAnimation]
        animation.duration = duration
        animation.repeatCount = .infinity

        /*
         // Draw triangle
         CAShapeLayer *triangle = [CAShapeLayer layer];
         UIBezierPath *trianglePath = [UIBezierPath bezierPath];
         CGFloat offsetY = size.height / 4;
         
         [trianglePath  moveToPoint:CGPointMake(0, size.height - offsetY)];
         [trianglePath addLineToPoint:CGPointMake(size.width / 2, size.height / 2 - offsetY)];
         [trianglePath addLineToPoint:CGPointMake(size.width, size.height - offsetY)];
         [trianglePath closePath];
         triangle.fillColor = tintColor.CGColor;
         triangle.path = trianglePath.CGPath;
         [triangle addAnimation:animation forKey:@"animation"];
         triangle.frame = CGRectMake(x, y, size.width, size.height);
         [layer addSublayer:triangle];
         */
        // Draw triangle
        let triangle: CAShapeLayer = CAShapeLayer()
        let trianglePath: UIBezierPath = UIBezierPath()
        let offsetY: CGFloat = size.height / 4
        
        trianglePath.move(to: CGPoint(x: 0, y: size.height - offsetY))
        trianglePath.addLine(to: CGPoint(x: size.width/2, y: (size.height/2)-offsetY))
        trianglePath.addLine(to: CGPoint(x: size.width, y: size.height - offsetY))
        trianglePath.close()
        
        triangle.fillColor = tintedColor.cgColor
        triangle.path = trianglePath.cgPath
        triangle.add(animation, forKey: "animation")
        triangle.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
        layer.addSublayer(triangle)
    }
    
}
