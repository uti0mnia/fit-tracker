//
//  FTButton.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-13.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTButtonFactory: NSObject {
    
    private override init() { }
    
    // The default button to be used around the app.
    public static func simpleButton(cornerRadius: CGFloat = 0) -> UIButton {
        let button = UIButton()
        button.setTitleColor(Colours.mainPrimary, for: .normal)
        button.titleLabel?.font = Fonts.simpleButton
        button.backgroundColor = Colours.lightForeground
        
        button.layer.shadowOffset = Layout.buttonShadowOffset
        button.layer.shadowColor = Colours.shadow.cgColor
        button.layer.cornerRadius = cornerRadius
        
        return button
    }
    
    // A button that makes it obvious what we want.
    public static func strongRoundedButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(Colours.lightTextColour, for: .normal)
        button.titleLabel?.font = Fonts.simpleButton
        button.backgroundColor = Colours.mainPrimary
        
        button.layer.cornerRadius = Layout.buttonCornerRadius
        
        return button
    }
    
    // A button with a contour
    public static func countourRoundedButton() -> UIButton {
        let button = FTButtonFactory.simpleButton(cornerRadius: Layout.buttonCornerRadius)
        
        button.backgroundColor = UIColor.white
        button.layer.borderColor = Colours.mainPrimary.cgColor
        button.layer.borderWidth = Layout.contourButtonBorderWidth
        
        return button
    }
    
    // A square button with custom colour.
    public static func destructiveButton(cornerRadius: CGFloat = 0) -> UIButton {
        let button = UIButton()
        button.setTitleColor(Colours.destructiveColour, for: .normal)
        button.titleLabel?.font = Fonts.simpleButton
        button.backgroundColor = Colours.lightForeground
        
        button.layer.cornerRadius = cornerRadius
        
        return button
    }
}
