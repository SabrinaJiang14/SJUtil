//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/28.
//

import Foundation
import UIKit

public enum AnimationType {
//    case NineDots
//    case TriplePulse
//    case FiveDots
//    case RotatingSquares
//    case DoubleBounce
//    case TwoDots
//    case ThreeDots
//    case BallPulse
    case BallClipRotate
    case BallClipRotatePulse
//    case BallClipRotateMultiple
//    case BallRotate
//    case BallZigZag
//    case BallZigZagDeflect
//    case BallTrianglePath
//    case BallScale
//    case LineScale
//    case LineScaleParty
//    case BallScaleMultiple
//    case BallPulseSync
//    case BallBeat
//    case LineScalePulseOut
//    case LineScalePulseOutRapid
//    case BallScaleRipple
//    case BallScaleRippleMultiple
    case TriangleSkewSpin
//    case BallGridBeat
    case BallGridPulse
//    case RotatingSandglass
//    case RotatingTrigons
    case TripleRings
//    case CookieTerminator
//    case BallSpinFadeLoader
}

let kIndicatorDefaultSize:CGFloat = 40.0

protocol IndicatorAnimationProtocol : NSObjectProtocol {
    func setupAnimationInLayer(layer:CALayer, size:CGSize, tintedColor:UIColor)
}
