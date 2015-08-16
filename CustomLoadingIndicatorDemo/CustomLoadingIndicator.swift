//
//  CustomLoadingIndicator.swift
//  CustomLoadingIndicatorDemo
//
//  Created by Matt McEachern on 8/16/15.
//  Copyright (c) 2015 Matt McEachern. All rights reserved.
//

import UIKit

private let INSTANCE_COUNT = 53
private let ANIMATION_DURATION = 2.0
private let ROTATION_COUNT = 3.0
private let INSTANCE_DIMENSION = 14.0
private let MOVE_OUT_OFFSET = 30
private let COLOR = UIColor.grayColor()
private let OPACITY = 0.75

class CustomLoadingIndicator: UIView {
    
    private var animating = false
    private var animationDuration = ANIMATION_DURATION
    
    private var replicationLayer: CAReplicatorLayer!
    private var instanceLayer: CAShapeLayer!
    private var instanceAnimation: CAAnimationGroup!
    
    init() {
        super.init(frame: CGRectZero)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    //gfdg
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        
        /*--------- Replication Layer ---------*/
        let replicationLayer = CAReplicatorLayer()
        replicationLayer.frame.origin = self.center
        replicationLayer.backgroundColor = UIColor.clearColor().CGColor
        // instance settings
        replicationLayer.instanceCount = INSTANCE_COUNT
        replicationLayer.instanceDelay = animationDuration / Double(INSTANCE_COUNT)
        replicationLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(ROTATION_COUNT * 2 * M_PI / Double(INSTANCE_COUNT)), 0.0, 0.0, 1.0)
        
        self.layer.addSublayer(replicationLayer)
        self.replicationLayer = replicationLayer
        
        /*------------Instance Layer------------*/
        let instanceLayer = CAShapeLayer()
        instanceLayer.backgroundColor = UIColor.clearColor().CGColor
        instanceLayer.opacity = Float(OPACITY)
        instanceLayer.transform = CATransform3DMakeScale(0.0, 0.0, 1.0)
        instanceLayer.frame = CGRect(x: 0, y: 0, width: INSTANCE_DIMENSION, height: INSTANCE_DIMENSION)
        // drawing the circle
        instanceLayer.fillColor = COLOR.CGColor
        instanceLayer.lineWidth = CGFloat(INSTANCE_DIMENSION / 2.0)
        instanceLayer.path = UIBezierPath(arcCenter: CGPoint(x: instanceLayer.bounds.width / 2.0, y: instanceLayer.bounds.height / 2.0), radius: CGFloat(INSTANCE_DIMENSION / 4.0), startAngle: CGFloat(0.0), endAngle: CGFloat(2 * M_PI), clockwise: true).CGPath
        
        self.instanceLayer = instanceLayer
        
        /*--------------Animations--------------*/
        let moveOutwardAnimation = CABasicAnimation(keyPath: "position")
        moveOutwardAnimation.toValue = NSValue(CGPoint: CGPoint(x: MOVE_OUT_OFFSET, y: MOVE_OUT_OFFSET))
        moveOutwardAnimation.duration = animationDuration
        
        let expandAnimation = CABasicAnimation(keyPath: "transform")
        expandAnimation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(0.0, 0.0, 1.0))
        expandAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
        expandAnimation.duration = animationDuration / 4.0 // expand during the first quater of the animation
        expandAnimation.fillMode = kCAFillModeForwards // maintain size after animations completes
        
        let shrinkAnimation = CABasicAnimation(keyPath: "transform")
        shrinkAnimation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
        shrinkAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(0.0, 0.0, 1.0))
        shrinkAnimation.duration = animationDuration / 4.0
        shrinkAnimation.fillMode = kCAFillModeForwards
        shrinkAnimation.beginTime = animationDuration * 3.0 / 4.0 // begins during the last quater of the animation
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [moveOutwardAnimation, expandAnimation, shrinkAnimation] // packages all the animations into one group, to be repeated indefinitely
        animationGroup.duration = animationDuration
        animationGroup.repeatCount = Float(Int.max)
        self.instanceAnimation = animationGroup
    }
    
    // MARK: public methods
    
    func startAnimating() {
        replicationLayer.addSublayer(instanceLayer)
        self.instanceLayer.addAnimation(self.instanceAnimation, forKey: nil)
        animating = true
    }
    
    func stopAnimating() {
        instanceLayer.removeAllAnimations()
        instanceLayer.removeFromSuperlayer()
        animating = false
    }
    
    func isAnimating() -> Bool {
        return animating
    }
    
    func setColor(color: UIColor) {
        instanceLayer.fillColor = color.CGColor
    }
}