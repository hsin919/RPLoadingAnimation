//
//  RPLoadingAnimationView.swift
//  RPLoadingAnimation
//
//  Created by naoyashiga on 2015/10/11.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

public enum RPLoadingAnimationType {
    case RotatingCircle, SpininngDot, LineScale, DotTrianglePath,
    DotSpinningLikeSkype, FunnyDotsA
}

class AnimationFactory {
    class func animationForType(type: RPLoadingAnimationType) -> RPLoadingAnimationDelegate {
        switch type {
        case .RotatingCircle:
            return RotatingCircle()
        case .SpininngDot:
            return SpininngDot()
        case .LineScale:
            return LineScale()
        case .DotTrianglePath:
            return DotTrianglePath()
        case .DotSpinningLikeSkype:
            return DotSpinningLikeSkype()
        case .FunnyDotsA:
            return FunnyDotsA()
        }
    }
}

public class RPLoadingAnimationView: UIView {
    private static let defaultType = RPLoadingAnimationType.FunnyDotsA
    private static let defaultColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1.0)
    private static let defaultSize = CGSize(width: 60, height: 60)
    
    var type: RPLoadingAnimationType
    var color: UIColor
    var size: CGSize
    
    var isAnimating = false
    var animation : RPLoadingAnimationDelegate?
    
    required public init?(coder aDecoder: NSCoder) {
        self.type = RPLoadingAnimationView.defaultType
        self.color = RPLoadingAnimationView.defaultColor
        self.size = RPLoadingAnimationView.defaultSize
        super.init(coder: aDecoder)
    }
    

    convenience init () {
        self.init(frame:CGRect.zero)
        self.type = RPLoadingAnimationView.defaultType
        self.color = RPLoadingAnimationView.defaultColor
        self.size = RPLoadingAnimationView.defaultSize
    }
    
    init(frame: CGRect, type: RPLoadingAnimationType = defaultType, color: UIColor = defaultColor, size: CGSize = defaultSize) {
        self.type = type
        self.color = color
        self.size = size
        super.init(frame: frame)
    }
    
    func setupAnimation() {
        animation = AnimationFactory.animationForType(type)
        layer.sublayers = nil
        animation?.setup(layer, size: size, color: color)
        isAnimating = true
    }
    
    func pauseAnimation() {
        animation?.pauseAnimation(layer)
        isAnimating = false
    }
    
    func resumeAnimation() {
        animation?.resumeAnimation(layer)
        isAnimating = true
    }
    
    func toggleAnimationStatus() {
        if(isAnimating) {
            pauseAnimation()
        } else {
            resumeAnimation()
        }
    }
}