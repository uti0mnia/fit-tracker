//
//  FTStrongButton.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-05.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

@IBDesignable
class FTStrongButton: FTButton {
    
    public override func commonInit() {
        super.commonInit()
        
        setTitleColor(FTColours.lightTextColour, for: .normal)
        titleLabel?.font = FTFonts.simpleButton
        backgroundColor = FTColours.mainPrimary
    }

}
