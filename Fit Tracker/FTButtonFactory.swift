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
        button.setTitleColor(FTColours.mainPrimary, for: .normal)
        button.titleLabel?.font = FTFonts.simpleButton
        button.backgroundColor = FTColours.lightForeground
        
        button.layer.shadowOffset = FTLayout.buttonShadowOffset
        button.layer.shadowColor = FTColours.shadow.cgColor
        button.layer.cornerRadius = cornerRadius
        
        return button
    }
    
    // A button that makes it obvious what we want.
    public static func strongButton(cornerRadius: CGFloat = 0) -> UIButton {
        let button = UIButton()
        button.setTitleColor(FTColours.lightTextColour, for: .normal)
        button.titleLabel?.font = FTFonts.simpleButton
        button.backgroundColor = FTColours.mainPrimary
        
        button.layer.cornerRadius = FTLayout.buttonCornerRadius
        
        return button
    }
    
    // A button with a contour
    public static func countourButton(cornerRadius: CGFloat = 0) -> UIButton {
        let button = FTButtonFactory.simpleButton(cornerRadius: FTLayout.buttonCornerRadius)
        
        button.backgroundColor = UIColor.white
        button.layer.borderColor = FTColours.mainPrimary.cgColor
        button.layer.borderWidth = FTLayout.contourButtonBorderWidth
        
        return button
    }
    
    // A square button with custom colour.
    public static func destructiveButton(cornerRadius: CGFloat = 0) -> UIButton {
        let button = UIButton()
        button.setTitleColor(FTColours.destructiveColour, for: .normal)
        button.titleLabel?.font = FTFonts.simpleButton
        button.backgroundColor = FTColours.lightForeground
        
        button.layer.cornerRadius = cornerRadius
        
        return button
    }
}
