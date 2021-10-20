//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/28.
//

import Foundation
import UIKit



public class IndicatorView : UIView {
    
    private var tintedColor: UIColor!
    private var size:CGFloat?
    private var animating:Bool?
    private var type:AnimationType?
    
    private var animationLayer:CALayer?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.type = .BallClipRotate
        self.tintedColor = .white
        self.size = kIndicatorDefaultSize;
        self.commonInit()
    }
    
    public init(type:AnimationType = .BallClipRotate, tintedColor:UIColor = .white, size:CGFloat = 40) {
        super.init(frame: .zero)
        self.type = type
        self.tintedColor = tintedColor
        self.size = size
        self.commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.animationLayer?.frame = self.bounds
        guard let animating = animating else { return }
        if animating {
            self.stopAnimating()
        }
        self.setupAnimation()
        
        if animating {
            self.startAnimating()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: size ?? 0, height: size ?? 0)
    }
    
    public func startAnimating() {
        if let sublayers = animationLayer?.sublayers, sublayers.count != 0 {
            self.setupAnimation()
        }
        self.isHidden = false
        self.animationLayer?.speed = 1.0
        self.animating = true
    }
    
    public func stopAnimating() {
        self.animationLayer?.speed = 0.0
        self.animating = false
        self.isHidden = true
    }
}

extension IndicatorView {
    private func commonInit() {
        self.isUserInteractionEnabled = false
        self.isHidden = true
        
        self.animationLayer = CALayer()
        self.layer.addSublayer(self.animationLayer!)
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentHuggingPriority(.required, for: .vertical)
    }
    
    private func setupAnimation() {
        self.animationLayer?.sublayers = nil
        let animation = IndicatorView.activityIndicatorAnimationForAnimationType(type: self.type!)
        animation.setupAnimationInLayer(layer: self.animationLayer!, size: CGSize(width: size ?? 0, height: size ?? 0), tintedColor: self.tintedColor)
        self.animationLayer?.speed = 0.0
    }
    
    func setType(type:AnimationType) {
        self.type = type
        self.setupAnimation()
    }
    
    func setSize(size:CGFloat) {
        self.size = size
        self.setupAnimation()
        self.invalidateIntrinsicContentSize()
    }
    
    func setTintColor(tintedColor:UIColor) {
        self.tintedColor = tintedColor
        self.setupAnimation()
    }
    
    static func activityIndicatorAnimationForAnimationType(type:AnimationType) -> IndicatorAnimationProtocol {
        switch type {
        case .TriangleSkewSpin:
            return TriangleSkewSpin()
        case .BallGridPulse:
            return BallGridPulse()
        case .TripleRings:
            return TripleRings()
        case .BallClipRotatePulse:
            return BallClipRotatePulse()
        case .BallClipRotate:
            return BallClipRotate()
        case .LineScale:
            return lineScale()
        }
    }
}
