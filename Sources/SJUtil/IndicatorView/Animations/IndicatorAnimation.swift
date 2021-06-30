//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/29.
//

import Foundation
import UIKit

public class IndicatorAnimation : NSObject {
    
    func createBasicAnimationWithKeyPath(keyPath:String) -> CABasicAnimation {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: keyPath)
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    func createKeyframeAnimationWithKeyPath(keyPath:String) -> CAKeyframeAnimation {
        let animation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: keyPath)
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    func createAnimationGroup() -> CAAnimationGroup {
        let animationGroup: CAAnimationGroup = CAAnimationGroup()
        animationGroup.isRemovedOnCompletion = false
        return animationGroup
    }
    
}
