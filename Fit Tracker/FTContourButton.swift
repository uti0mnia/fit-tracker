//
//  FTContourButton.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-05.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

@IBDesignable
class FTContourButton: FTButton {
    
    public override func commonInit() {
        super.commonInit()
        
        setTitleColor(FTColours.mainPrimary, for: .normal)
        titleLabel?.font = FTFonts.simpleButton
        backgroundColor = FTColours.lightForeground
        
        layer.shadowOffset = FTLayout.buttonShadowOffset
        layer.shadowColor = FTColours.shadow.cgColor
        
        backgroundColor = FTColours.lightForeground
        layer.borderColor = FTColours.mainPrimary.cgColor
        layer.borderWidth = FTLayout.contourButtonBorderWidth
    }

}
