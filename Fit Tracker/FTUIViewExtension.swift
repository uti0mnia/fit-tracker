//
//  FTViewExtension.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-04-04.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

extension UIView {
    
    public func ft_shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
}
